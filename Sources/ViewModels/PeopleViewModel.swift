import Foundation
import Combine

@MainActor
public class PeopleViewModel: ObservableObject {
    @Published public var people: [Person] = []
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    private let peopleService = PeopleService()
    
    public init() {}
    
    public func fetchPeople() async {
        isLoading = true
        errorMessage = nil
        
        do {
            people = try await peopleService.fetchPeople()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    public func addPerson(name: String, birthday: Date?, notes: String?) async {
        do {
            let newPerson = try await peopleService.createPerson(
                name: name,
                birthday: birthday,
                notes: notes
            )
            people.append(newPerson)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func deletePerson(_ person: Person) async {
        do {
            try await peopleService.deletePerson(id: person.id)
            people.removeAll { $0.id == person.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func searchPeople(query: String) -> [Person] {
        if query.isEmpty {
            return people
        }
        return people.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}

