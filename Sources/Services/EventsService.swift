import Foundation
@preconcurrency import Supabase
@preconcurrency import PostgREST

@MainActor
class EventsService: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseManager.shared
    private let tableName = "events"
    
    // MARK: - Fetch Operations
    
    func fetchAll() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: [Event] = try await supabase
                .from(tableName)
                .select()
                .order("event_date")
                .execute()
                .value
            
            events = response
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching events: \(error)")
        }
        
        isLoading = false
    }
    
    func fetchEventsInRange(from startDate: Date, to endDate: Date) async {
        isLoading = true
        errorMessage = nil
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        
        do {
            let response: [Event] = try await supabase
                .from(tableName)
                .select()
                .gte("event_date", value: formatter.string(from: startDate))
                .lte("event_date", value: formatter.string(from: endDate))
                .order("event_date")
                .execute()
                .value
            
            events = response
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching events in range: \(error)")
        }
        
        isLoading = false
    }
    
    func getUpcomingEvents(limit: Int = 10) -> [Event] {
        let now = Date()
        return events
            .filter { $0.eventDate >= now }
            .sorted { $0.eventDate < $1.eventDate }
            .prefix(limit)
            .map { $0 }
    }
    
    func getEventsForDate(_ date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.eventDate, inSameDayAs: date) }
    }
    
    func getEventsByPerson(_ personId: UUID) -> [Event] {
        events.filter { $0.personId == personId }
    }
    
    func getEventsByCategory(_ category: EventCategory) -> [Event] {
        events.filter { $0.category == category }
    }
    
    // MARK: - CRUD Operations
    
    func create(
        title: String,
        eventDate: Date,
        eventTime: Date? = nil,
        personId: UUID? = nil,
        category: EventCategory = .other,
        notes: String? = nil,
        reminderEnabled: Bool = false,
        reminderDaysBefore: Int = 1,
        recurring: RecurringType = .none
    ) async throws -> Event {
        isLoading = true
        errorMessage = nil
        
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "EventsService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let newEvent = Event(
            userId: userId,
            title: title,
            eventDate: eventDate,
            eventTime: eventTime,
            personId: personId,
            category: category,
            notes: notes,
            reminderEnabled: reminderEnabled,
            reminderDaysBefore: reminderDaysBefore,
            recurring: recurring
        )
        
        do {
            let response: Event = try await supabase
                .from(tableName)
                .insert(newEvent)
                .select()
                .single()
                .execute()
                .value
            
            events.append(response)
            events.sort { $0.eventDate < $1.eventDate }
            
            isLoading = false
            return response
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func update(_ event: Event) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: Event = try await supabase
                .from(tableName)
                .update(event)
                .eq("id", value: event.id.uuidString)
                .select()
                .single()
                .execute()
                .value
            
            if let index = events.firstIndex(where: { $0.id == event.id }) {
                events[index] = response
                events.sort { $0.eventDate < $1.eventDate }
            }
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
    
    func delete(_ event: Event) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let _: EmptyResponse = try await supabase
                .from(tableName)
                .delete()
                .eq("id", value: event.id.uuidString)
                .execute()
                .value
            
            events.removeAll { $0.id == event.id }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            throw error
        }
    }
}

