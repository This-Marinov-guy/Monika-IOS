import SwiftUI

@MainActor
public class ThemeManager: ObservableObject {
    @Published public var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    public init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    public var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    
    func toggleTheme() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDarkMode.toggle()
        }
    }
}

// MARK: - Color Extensions
extension Color {
    // Primary Brand Colors (Airbnb Design System)
    static let appPrimary = Color(hex: "#FF5A5F")
    static let appPrimaryDark = Color(hex: "#E0484C")
    static let appPrimaryLight = Color(hex: "#FF7E82")
    static let appPrimarySubtle = Color(hex: "#FFE8E9")
    
    // Neutral Colors
    static let neutralBlack = Color(hex: "#222222")
    static let neutralGray900 = Color(hex: "#484848")
    static let neutralGray700 = Color(hex: "#717171")
    static let neutralGray500 = Color(hex: "#B0B0B0")
    static let neutralGray300 = Color(hex: "#DDDDDD")
    static let neutralGray100 = Color(hex: "#EBEBEB")
    static let neutralGray50 = Color(hex: "#F7F7F7")
    static let neutralWhite = Color(hex: "#FFFFFF")
    
    // Semantic Colors
    static let semanticSuccess = Color(hex: "#00A699")
    static let semanticWarning = Color(hex: "#FFB400")
    static let semanticError = Color(hex: "#FF5A5F")
    static let semanticInfo = Color(hex: "#007AFF")
    
    // Background Colors
    static let appBackground = Color(hex: "#FFFFFF")
    static let appBackgroundSecondary = Color(hex: "#F7F7F7")
    static let appBackgroundTertiary = Color(hex: "#EBEBEB")
    
    // Text Colors
    static let appTextPrimary = Color(hex: "#222222")
    static let appTextSecondary = Color(hex: "#717171")
    static let appTextTertiary = Color(hex: "#B0B0B0")
    static let appTextInverse = Color(hex: "#FFFFFF")
    static let appTextLink = Color(hex: "#007AFF")
    
    // Category colors
    static let categoryBirthday = Color(hex: "#FF5A5F")
    static let categoryAnniversary = Color(hex: "#E0484C")
    static let categoryHoliday = Color(hex: "#FFB400")
    static let categoryReminder = Color(hex: "#00A699")
    static let categoryOther = Color(hex: "#717171")
    
    // Priority colors
    static let priorityLow = Color(hex: "#B0B0B0")
    static let priorityMedium = Color(hex: "#007AFF")
    static let priorityHigh = Color(hex: "#FFB400")
    static let priorityWishlist = Color(hex: "#FF5A5F")
    
    // Helper init from hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Adaptive Colors
extension Color {
    static func adaptive(light: Color, dark: Color) -> Color {
        Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0) // Placeholder, will use environment
    }
    
    static var adaptiveBackground: Color {
        #if os(iOS)
        return Color(uiColor: .systemBackground)
        #else
        return Color(nsColor: .windowBackgroundColor)
        #endif
    }
    
    static var adaptiveSecondaryBackground: Color {
        #if os(iOS)
        return Color(uiColor: .secondarySystemBackground)
        #else
        return Color(nsColor: .controlBackgroundColor)
        #endif
    }
    
    static var adaptiveSurface: Color {
        #if os(iOS)
        return Color(uiColor: .systemBackground)
        #else
        return Color(nsColor: .controlBackgroundColor)
        #endif
    }
}

