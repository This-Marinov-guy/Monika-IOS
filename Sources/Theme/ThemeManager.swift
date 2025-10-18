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
    // Airbnb-inspired primary color
    static let appPrimary = Color(hex: "#FF385C")
    static let appPrimaryDark = Color(hex: "#E31C5F")
    
    // Semantic colors for light mode
    static let appBackground = Color(hex: "#FFFFFF")
    static let appBackgroundSecondary = Color(hex: "#F7F7F7")
    static let appSurface = Color(hex: "#FFFFFF")
    static let appBorder = Color(hex: "#DDDDDD")
    
    // Dark mode colors
    static let appBackgroundDark = Color(hex: "#000000")
    static let appBackgroundSecondaryDark = Color(hex: "#1A1A1A")
    static let appSurfaceDark = Color(hex: "#222222")
    static let appBorderDark = Color(hex: "#3A3A3A")
    
    // Text colors
    static let appTextPrimary = Color(hex: "#222222")
    static let appTextSecondary = Color(hex: "#717171")
    static let appTextTertiary = Color(hex: "#B0B0B0")
    
    static let appTextPrimaryDark = Color(hex: "#FFFFFF")
    static let appTextSecondaryDark = Color(hex: "#B0B0B0")
    static let appTextTertiaryDark = Color(hex: "#717171")
    
    // Category colors
    static let categoryBirthday = Color(hex: "#FF385C")
    static let categoryAnniversary = Color(hex: "#E00B5C")
    static let categoryHoliday = Color(hex: "#FFB400")
    static let categoryReminder = Color(hex: "#00A699")
    static let categoryOther = Color(hex: "#8B8B8B")
    
    // Priority colors
    static let priorityLow = Color.gray
    static let priorityMedium = Color.blue
    static let priorityHigh = Color.orange
    static let priorityWishlist = Color.purple
    
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

