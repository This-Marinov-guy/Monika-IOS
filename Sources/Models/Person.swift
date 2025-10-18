import Foundation

public struct Person: Identifiable, Codable, Hashable {
    public let id: UUID
    public let userId: UUID
    public var name: String
    var birthday: Date?
    var avatarUrl: String?
    var notes: String?
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case birthday
        case avatarUrl = "avatar_url"
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        name: String,
        birthday: Date? = nil,
        avatarUrl: String? = nil,
        notes: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.birthday = birthday
        self.avatarUrl = avatarUrl
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Helper computed property for age
    var age: Int? {
        guard let birthday = birthday else { return nil }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year
    }
    
    // Helper computed property for upcoming birthday
    var daysUntilBirthday: Int? {
        guard let birthday = birthday else { return nil }
        let calendar = Calendar.current
        let now = Date()
        
        var nextBirthday = calendar.date(
            byAdding: .year,
            value: calendar.component(.year, from: now) - calendar.component(.year, from: birthday),
            to: birthday
        )!
        
        if nextBirthday < now {
            nextBirthday = calendar.date(byAdding: .year, value: 1, to: nextBirthday)!
        }
        
        let components = calendar.dateComponents([.day], from: now, to: nextBirthday)
        return components.day
    }
}

