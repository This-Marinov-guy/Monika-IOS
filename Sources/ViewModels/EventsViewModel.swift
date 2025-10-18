import Foundation
import Combine

@MainActor
public class EventsViewModel: ObservableObject {
    @Published public var events: [Event] = []
    @Published public var upcomingEvents: [Event] = []
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    private let eventsService = EventsService()
    
    public init() {}
    
    public func fetchEvents(startDate: Date, endDate: Date) async {
        isLoading = true
        errorMessage = nil
        
        do {
            events = try await eventsService.fetchEvents(startDate: startDate, endDate: endDate)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    public func fetchUpcomingEvents(limit: Int = 10) async {
        do {
            upcomingEvents = try await eventsService.fetchUpcomingEvents(limit: limit)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func addEvent(
        title: String,
        eventDate: Date,
        eventTime: Date?,
        personId: UUID?,
        category: EventCategory,
        notes: String?,
        reminderEnabled: Bool,
        reminderDaysBefore: Int?,
        recurring: RecurringType
    ) async {
        do {
            let newEvent = try await eventsService.createEvent(
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
            events.append(newEvent)
            upcomingEvents.append(newEvent)
            upcomingEvents.sort { $0.eventDate < $1.eventDate }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func deleteEvent(_ event: Event) async {
        do {
            try await eventsService.deleteEvent(id: event.id)
            events.removeAll { $0.id == event.id }
            upcomingEvents.removeAll { $0.id == event.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func eventsForDate(_ date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.eventDate, inSameDayAs: date) }
    }
}

