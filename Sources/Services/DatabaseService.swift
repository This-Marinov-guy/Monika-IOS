import Foundation
@preconcurrency import Supabase
@preconcurrency import PostgREST

@MainActor
class DatabaseService: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseManager.shared
    
    // MARK: - Generic CRUD Operations
    
    func fetch<T: Decodable>(
        from table: String,
        filter: ((PostgrestFilterBuilder) -> PostgrestFilterBuilder)? = nil
    ) async throws -> [T] {
        isLoading = true
        defer { isLoading = false }
        
        do {
            var query = supabase.from(table).select()
            
            if let filter = filter {
                query = filter(query)
            }
            
            let response: [T] = try await query.execute().value
            errorMessage = nil
            return response
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    func fetchOne<T: Decodable>(
        from table: String,
        id: UUID
    ) async throws -> T {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response: T = try await supabase
                .from(table)
                .select()
                .eq("id", value: id.uuidString)
                .single()
                .execute()
                .value
            
            errorMessage = nil
            return response
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    func insert<T: Encodable & Decodable>(
        into table: String,
        values: T
    ) async throws -> T {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response: T = try await supabase
                .from(table)
                .insert(values)
                .select()
                .single()
                .execute()
                .value
            
            errorMessage = nil
            return response
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    func update<T: Encodable & Decodable>(
        table: String,
        id: UUID,
        values: T
    ) async throws -> T {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response: T = try await supabase
                .from(table)
                .update(values)
                .eq("id", value: id.uuidString)
                .select()
                .single()
                .execute()
                .value
            
            errorMessage = nil
            return response
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    func delete(
        from table: String,
        id: UUID
    ) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let _: EmptyResponse = try await supabase
                .from(table)
                .delete()
                .eq("id", value: id.uuidString)
                .execute()
                .value
            
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
}

