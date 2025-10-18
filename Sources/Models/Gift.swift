import Foundation

enum GiftPriority: String, Codable, CaseIterable {
    case low
    case medium
    case high
    case wishlist
    
    var displayName: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        case .wishlist: return "Wishlist"
        }
    }
    
    var icon: String {
        switch self {
        case .low: return "arrow.down.circle"
        case .medium: return "minus.circle"
        case .high: return "arrow.up.circle"
        case .wishlist: return "star.circle"
        }
    }
    
    var color: String {
        switch self {
        case .low: return "gray"
        case .medium: return "blue"
        case .high: return "orange"
        case .wishlist: return "purple"
        }
    }
}

struct Gift: Identifiable, Codable, Hashable {
    let id: UUID
    let userId: UUID
    var personId: UUID
    var eventId: UUID?
    var name: String
    var price: Decimal?
    var link: String?
    var purchased: Bool
    var priority: GiftPriority
    var notes: String?
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case personId = "person_id"
        case eventId = "event_id"
        case name
        case price
        case link
        case purchased
        case priority
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        personId: UUID,
        eventId: UUID? = nil,
        name: String,
        price: Decimal? = nil,
        link: String? = nil,
        purchased: Bool = false,
        priority: GiftPriority = .medium,
        notes: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.personId = personId
        self.eventId = eventId
        self.name = name
        self.price = price
        self.link = link
        self.purchased = purchased
        self.priority = priority
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Helper computed property for formatted price
    var formattedPrice: String? {
        guard let price = price else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: price as NSDecimalNumber)
    }
}

