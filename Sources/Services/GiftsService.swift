import Foundation
@preconcurrency import Supabase
@preconcurrency import PostgREST

@MainActor
class GiftsService: ObservableObject {
    @Published var gifts: [Gift] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseManager.shared
    private let tableName = "gifts"
    
    // MARK: - Fetch Operations
    
    func fetchAll() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: [Gift] = try await supabase
                .from(tableName)
                .select()
                .order("created_at", ascending: false)
                .execute()
                .value
            
            gifts = response
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching gifts: \(error)")
        }
        
        isLoading = false
    }
    
    func getGiftsByPerson(_ personId: UUID) -> [Gift] {
        gifts.filter { $0.personId == personId }
    }
    
    func getGiftsByEvent(_ eventId: UUID) -> [Gift] {
        gifts.filter { $0.eventId == eventId }
    }
    
    func getGiftsByPriority(_ priority: GiftPriority) -> [Gift] {
        gifts.filter { $0.priority == priority }
    }
    
    func getPurchasedGifts() -> [Gift] {
        gifts.filter { $0.purchased }
    }
    
    func getUnpurchasedGifts() -> [Gift] {
        gifts.filter { !$0.purchased }
    }
    
    // MARK: - CRUD Operations
    
    func create(
        personId: UUID,
        name: String,
        eventId: UUID? = nil,
        price: Decimal? = nil,
        link: String? = nil,
        priority: GiftPriority = .medium,
        notes: String? = nil
    ) async throws -> Gift {
        isLoading = true
        errorMessage = nil
        
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "GiftsService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let newGift = Gift(
            userId: userId,
            personId: personId,
            eventId: eventId,
            name: name,
            price: price,
            link: link,
            priority: priority,
            notes: notes
        )
        
        do {
            let response: Gift = try await supabase
                .from(tableName)
                .insert(newGift)
                .select()
                .single()
                .execute()
                .value
            
            gifts.append(response)
            
            isLoading = false
            return response
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func update(_ gift: Gift) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: Gift = try await supabase
                .from(tableName)
                .update(gift)
                .eq("id", value: gift.id.uuidString)
                .select()
                .single()
                .execute()
                .value
            
            if let index = gifts.firstIndex(where: { $0.id == gift.id }) {
                gifts[index] = response
            }
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func togglePurchased(_ gift: Gift) async throws {
        var updatedGift = gift
        updatedGift.purchased.toggle()
        try await update(updatedGift)
    }
    
    func delete(_ gift: Gift) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let _: EmptyResponse = try await supabase
                .from(tableName)
                .delete()
                .eq("id", value: gift.id.uuidString)
                .execute()
                .value
            
            gifts.removeAll { $0.id == gift.id }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    // MARK: - ViewModel-friendly wrappers
    
    func fetchGifts() async throws -> [Gift] {
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "GiftsService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let response: [Gift] = try await supabase
            .from(tableName)
            .select()
            .eq("user_id", value: userId.uuidString)
            .order("name")
            .execute()
            .value
        
        return response
    }
    
    func fetchGiftsForPerson(personId: UUID) async throws -> [Gift] {
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "GiftsService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let response: [Gift] = try await supabase
            .from(tableName)
            .select()
            .eq("user_id", value: userId.uuidString)
            .eq("person_id", value: personId.uuidString)
            .order("name")
            .execute()
            .value
        
        return response
    }
    
    func createGift(
        personId: UUID,
        eventId: UUID?,
        name: String,
        price: Double?,
        link: String?,
        purchased: Bool,
        priority: GiftPriority,
        notes: String?
    ) async throws -> Gift {
        let decimalPrice = price.map { Decimal($0) }
        return try await create(
            personId: personId,
            name: name,
            eventId: eventId,
            price: decimalPrice,
            link: link,
            priority: priority,
            notes: notes
        )
    }
    
    func updateGift(
        id: UUID,
        personId: UUID,
        eventId: UUID?,
        name: String,
        price: Double?,
        link: String?,
        purchased: Bool,
        priority: GiftPriority,
        notes: String?
    ) async throws -> Gift {
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "GiftsService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let decimalPrice = price.map { Decimal($0) }
        let updatedGift = Gift(
            id: id,
            userId: userId,
            personId: personId,
            eventId: eventId,
            name: name,
            price: decimalPrice,
            link: link,
            purchased: purchased,
            priority: priority,
            notes: notes
        )
        
        try await update(updatedGift)
        return updatedGift
    }
    
    func deleteGift(id: UUID) async throws {
        let _: EmptyResponse = try await supabase
            .from(tableName)
            .delete()
            .eq("id", value: id.uuidString)
            .execute()
            .value
    }
}

