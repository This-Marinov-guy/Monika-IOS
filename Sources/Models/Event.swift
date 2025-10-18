import Foundation

public enum EventCategory: String, Codable, CaseIterable {
    case birthday
    case anniversary
    case holiday
    case reminder
    case other
    
    var displayName: String {
        switch self {
        case .birthday: return "Birthday"
        case .anniversary: return "Anniversary"
        case .holiday: return "Holiday"
        case .reminder: return "Reminder"
        case .other: return "Other"
        }
    }
    
    var icon: String {
        switch self {
        case .birthday: return "gift.fill"
        case .anniversary: return "heart.fill"
        case .holiday: return "star.fill"
        case .reminder: return "bell.fill"
        case .other: return "calendar"
        }
    }
}

public enum RecurringType: String, Codable, CaseIterable {
    case none
    case weekly
    case monthly
    case yearly
    
    var displayName: String {
        switch self {
        case .none: return "Never"
        case .weekly: return "Weekly"
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        }
    }
}

public struct Event: Identifiable, Codable, Hashable {
    public let id: UUID
    public let userId: UUID
    public var title: String
    var eventDate: Date
    var eventTime: Date?
    var personId: UUID?
    var category: EventCategory
    var notes: String?
    var reminderEnabled: Bool
    var reminderDaysBefore: Int
    var recurring: RecurringType
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case eventDate = "event_date"
        case eventTime = "event_time"
        case personId = "person_id"
        case category
        case notes
        case reminderEnabled = "reminder_enabled"
        case reminderDaysBefore = "reminder_days_before"
        case recurring
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        title: String,
        eventDate: Date,
        eventTime: Date? = nil,
        personId: UUID? = nil,
        category: EventCategory = .other,
        notes: String? = nil,
        reminderEnabled: Bool = false,
        reminderDaysBefore: Int = 1,
        recurring: RecurringType = .none,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.title = title
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.personId = personId
        self.category = category
        self.notes = notes
        self.reminderEnabled = reminderEnabled
        self.reminderDaysBefore = reminderDaysBefore
        self.recurring = recurring
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Helper computed property for days until event
    var daysUntilEvent: Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: now), to: calendar.startOfDay(for: eventDate))
        return components.day ?? 0
    }
    
    // Helper computed property to check if event is today
    var isToday: Bool {
        Calendar.current.isDateInToday(eventDate)
    }
    
    // Helper computed property to check if event is upcoming (within next 30 days)
    var isUpcoming: Bool {
        daysUntilEvent >= 0 && daysUntilEvent <= 30
    }
}

