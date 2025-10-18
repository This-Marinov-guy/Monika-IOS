import Foundation
import Combine

@MainActor
public class GiftsViewModel: ObservableObject {
    @Published public var gifts: [Gift] = []
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    private let giftsService = GiftsService()
    
    public init() {}
    
    public func fetchGifts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            gifts = try await giftsService.fetchGifts()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    public func fetchGiftsForPerson(personId: UUID) async -> [Gift] {
        do {
            return try await giftsService.fetchGiftsForPerson(personId: personId)
        } catch {
            errorMessage = error.localizedDescription
            return []
        }
    }
    
    public func addGift(
        personId: UUID,
        eventId: UUID?,
        name: String,
        price: Double?,
        link: String?,
        priority: GiftPriority,
        notes: String?
    ) async {
        do {
            let newGift = try await giftsService.createGift(
                personId: personId,
                eventId: eventId,
                name: name,
                price: price,
                link: link,
                purchased: false,
                priority: priority,
                notes: notes
            )
            gifts.append(newGift)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func togglePurchased(_ gift: Gift) async {
        do {
            let updatedGift = try await giftsService.updateGift(
                id: gift.id,
                personId: gift.personId,
                eventId: gift.eventId,
                name: gift.name,
                price: gift.price.map { Double(truncating: $0 as NSNumber) },
                link: gift.link,
                purchased: !gift.purchased,
                priority: gift.priority,
                notes: gift.notes
            )
            if let index = gifts.firstIndex(where: { $0.id == gift.id }) {
                gifts[index] = updatedGift
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func deleteGift(_ gift: Gift) async {
        do {
            try await giftsService.deleteGift(id: gift.id)
            gifts.removeAll { $0.id == gift.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func giftsGroupedByPerson() -> [(personId: UUID, gifts: [Gift])] {
        let grouped = Dictionary(grouping: gifts, by: { $0.personId })
        return grouped.map { (personId: $0.key, gifts: $0.value) }
            .sorted { $0.gifts.count > $1.gifts.count }
    }
}

