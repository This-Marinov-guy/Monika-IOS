import Foundation
@preconcurrency import Supabase
@preconcurrency import PostgREST

@MainActor
class PeopleService: ObservableObject {
    @Published var people: [Person] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseManager.shared
    private let tableName = "people"
    
    // MARK: - Fetch Operations
    
    func fetchAll() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: [Person] = try await supabase
                .from(tableName)
                .select()
                .order("name")
                .execute()
                .value
            
            people = response
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching people: \(error)")
        }
        
        isLoading = false
    }
    
    func search(query: String) -> [Person] {
        guard !query.isEmpty else { return people }
        return people.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
    // MARK: - CRUD Operations
    
    func create(name: String, birthday: Date? = nil, notes: String? = nil) async throws -> Person {
        isLoading = true
        errorMessage = nil
        
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "PeopleService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let newPerson = Person(
            userId: userId,
            name: name,
            birthday: birthday,
            notes: notes
        )
        
        do {
            let response: Person = try await supabase
                .from(tableName)
                .insert(newPerson)
                .select()
                .single()
                .execute()
                .value
            
            people.append(response)
            people.sort { $0.name < $1.name }
            
            isLoading = false
            return response
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func update(_ person: Person) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: Person = try await supabase
                .from(tableName)
                .update(person)
                .eq("id", value: person.id.uuidString)
                .select()
                .single()
                .execute()
                .value
            
            if let index = people.firstIndex(where: { $0.id == person.id }) {
                people[index] = response
                people.sort { $0.name < $1.name }
            }
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func delete(_ person: Person) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let _: EmptyResponse = try await supabase
                .from(tableName)
                .delete()
                .eq("id", value: person.id.uuidString)
                .execute()
                .value
            
            people.removeAll { $0.id == person.id }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func getPerson(byId id: UUID) -> Person? {
        people.first { $0.id == id }
    }
}

