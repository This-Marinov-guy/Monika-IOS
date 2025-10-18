import SwiftUI

enum DesignTokens {
    // MARK: - Colors (Monika Custom Design System)
    enum Colors {
        // Primary Brand (Indigo)
        static let primary = Color(hex: "6366F1")
        static let primaryDark = Color(hex: "4F46E5")
        static let primaryLight = Color(hex: "818CF8")
        static let primaryGlow = Color(hex: "A5B4FC")
        static let primarySubtle = Color(hex: "E0E7FF")
        
        // Secondary Accent (Pink)
        static let accent = Color(hex: "EC4899")
        static let accentDark = Color(hex: "DB2777")
        static let accentLight = Color(hex: "F472B6")
        static let accentSubtle = Color(hex: "FCE7F3")
        
        // Neutral Slate
        static let black = Color(hex: "0F172A")
        static let slate900 = Color(hex: "1E293B")
        static let slate800 = Color(hex: "334155")
        static let slate700 = Color(hex: "475569")
        static let slate600 = Color(hex: "64748B")
        static let slate500 = Color(hex: "94A3B8")
        static let slate400 = Color(hex: "CBD5E1")
        static let slate300 = Color(hex: "E2E8F0")
        static let slate200 = Color(hex: "F1F5F9")
        static let slate100 = Color(hex: "F8FAFC")
        static let white = Color.white
        
        // Semantic
        static let success = Color(hex: "10B981")
        static let successLight = Color(hex: "D1FAE5")
        static let warning = Color(hex: "F59E0B")
        static let warningLight = Color(hex: "FEF3C7")
        static let error = Color(hex: "EF4444")
        static let errorLight = Color(hex: "FEE2E2")
        static let info = Color(hex: "3B82F6")
        static let infoLight = Color(hex: "DBEAFE")
        
        // Background - Adaptive for Light/Dark Mode
        static let background = Color(hex: "FFFFFF")
        static let backgroundSecondary = Color(hex: "F8FAFC")
        static let backgroundTertiary = Color(hex: "F1F5F9")
        static let backgroundDark = Color(hex: "0F172A")
        static let backgroundDarkSecondary = Color(hex: "1E293B")
        static let backgroundDarkTertiary = Color(hex: "334155")
        static let surface = Color.white
        static let surfaceDark = Color(hex: "1E293B")
        
        // Text - Adaptive for Light/Dark Mode
        static let textPrimary = Color(hex: "0F172A")
        static let textPrimaryDark = Color(hex: "F8FAFC")
        static let textSecondary = Color(hex: "475569")
        static let textSecondaryDark = Color(hex: "CBD5E1")
        static let textTertiary = Color(hex: "94A3B8")
        static let textTertiaryDark = Color(hex: "94A3B8")
        static let textInverse = Color.white
        static let textBrand = Color(hex: "6366F1")
        static let textAccent = Color(hex: "EC4899")
    }
    
    // MARK: - Gradients
    enum Gradients {
        static let primary = LinearGradient(
            colors: [Color(hex: "6366F1"), Color(hex: "EC4899")],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let secondary = LinearGradient(
            colors: [Color(hex: "818CF8"), Color(hex: "F472B6")],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let dark = LinearGradient(
            colors: [Color(hex: "4F46E5"), Color(hex: "DB2777")],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let subtle = LinearGradient(
            colors: [Color(hex: "E0E7FF"), Color(hex: "FCE7F3")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let vertical = LinearGradient(
            colors: [Color(hex: "6366F1"), Color(hex: "EC4899")],
            startPoint: .top,
            endPoint: .bottom
        )
        
        // Adaptive background gradients for light mode
        static let backgroundLight = LinearGradient(
            colors: [
                Color(hex: "E0E7FF").opacity(0.3),
                Color(hex: "F8FAFC"),
                Color.white
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let backgroundLightCalendar = LinearGradient(
            colors: [
                Color(hex: "E0E7FF").opacity(0.4),
                Color(hex: "F8FAFC"),
                Color.white
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let backgroundLightPeople = LinearGradient(
            colors: [
                Color(hex: "E0E7FF").opacity(0.3),
                Color(hex: "F8FAFC"),
                Color.white
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let backgroundLightGifts = LinearGradient(
            colors: [
                Color(hex: "FCE7F3").opacity(0.3),
                Color(hex: "F8FAFC"),
                Color.white
            ],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        
        // Adaptive background gradients for dark mode
        static let backgroundDark = LinearGradient(
            colors: [
                Color(hex: "4F46E5").opacity(0.15),
                Color(hex: "1E293B"),
                Color(hex: "0F172A")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let backgroundDarkCalendar = LinearGradient(
            colors: [
                Color(hex: "4F46E5").opacity(0.2),
                Color(hex: "1E293B"),
                Color(hex: "0F172A")
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let backgroundDarkPeople = LinearGradient(
            colors: [
                Color(hex: "4F46E5").opacity(0.15),
                Color(hex: "1E293B"),
                Color(hex: "0F172A")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let backgroundDarkGifts = LinearGradient(
            colors: [
                Color(hex: "DB2777").opacity(0.15),
                Color(hex: "1E293B"),
                Color(hex: "0F172A")
            ],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
    }
    
    // MARK: - Spacing (Airbnb Design System)
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let base: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xl2: CGFloat = 40
        static let xl3: CGFloat = 48
        static let xl4: CGFloat = 64
        
        // Component spacing
        static let cardPadding: CGFloat = 16
        static let sectionPadding: CGFloat = 24
        static let screenPadding: CGFloat = 24
        static let listItemPadding: CGFloat = 16
        
        // Convenience aliases
        static let small = sm
        static let medium = base
        static let large = lg
    }
    
    // MARK: - Border Radius (Custom Rounded Design)
    enum BorderRadius {
        static let none: CGFloat = 0
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
        static let xl2: CGFloat = 24
        static let xl3: CGFloat = 32
        static let full: CGFloat = 9999
        
        // Component radii (more rounded for uniqueness)
        static let button: CGFloat = 16
        static let buttonLarge: CGFloat = 20
        static let card: CGFloat = 20
        static let cardLarge: CGFloat = 24
        static let image: CGFloat = 16
        static let modal: CGFloat = 24
        static let sheet: CGFloat = 24
        static let chip: CGFloat = 24
        static let input: CGFloat = 12
        static let badge: CGFloat = 12
    }
    
    // MARK: - Shadows (Colored Shadows for Depth)
    enum Shadow {
        static let none = (radius: 0.0, x: 0.0, y: 0.0, opacity: 0.0)
        static let small = (radius: 4.0, x: 0.0, y: 2.0, opacity: 0.08)
        static let medium = (radius: 12.0, x: 0.0, y: 4.0, opacity: 0.12)
        static let large = (radius: 24.0, x: 0.0, y: 8.0, opacity: 0.16)
        static let colored = (radius: 16.0, x: 0.0, y: 4.0, opacity: 0.2)
        static let glow = (radius: 20.0, x: 0.0, y: 0.0, opacity: 0.3)
        
        // For cards (with colored shadow)
        static let card = (radius: 12.0, x: 0.0, y: 4.0, opacity: 0.12)
    }
    
    // MARK: - Typography (Bold, Modern, Distinctive)
    enum Typography {
        // Display (extra bold, for hero sections)
        static let displayLarge = Font.system(size: 40, weight: .black, design: .rounded)
        static let displayMedium = Font.system(size: 32, weight: .heavy, design: .rounded)
        
        // Large Title & Titles (bold, rounded)
        static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title1 = Font.system(size: 24, weight: .bold, design: .rounded)
        static let title2 = Font.system(size: 20, weight: .semibold, design: .rounded)
        static let title3 = Font.system(size: 18, weight: .semibold, design: .rounded)
        
        // Headline & Body
        static let headline = Font.system(size: 16, weight: .semibold, design: .rounded)
        static let body = Font.system(size: 16, weight: .regular)
        static let bodyEmphasis = Font.system(size: 16, weight: .semibold)
        static let callout = Font.system(size: 15, weight: .medium)
        static let subheadline = Font.system(size: 14, weight: .medium)
        
        // Small text
        static let footnote = Font.system(size: 13, weight: .regular)
        static let caption = Font.system(size: 12, weight: .medium)
        static let overline = Font.system(size: 11, weight: .semibold).uppercaseSmallCaps()
        
        // Convenience aliases
        static let title = title2
        static let headlineSmall = title3
        static let bodyMedium = body
        static let labelLarge = headline
    }
    
    // MARK: - Animation Durations (Airbnb Design System)
    enum Animation {
        static let instant: Double = 0.1
        static let fast: Double = 0.2
        static let normal: Double = 0.3
        static let slow: Double = 0.4
        static let verySlow: Double = 0.5
    }
    
    // MARK: - Icon Sizes (Airbnb Design System)
    enum IconSize {
        static let small: CGFloat = 16
        static let medium: CGFloat = 20
        static let large: CGFloat = 24
        static let xlarge: CGFloat = 32
        
        // Tab bar specific
        static let tabBar: CGFloat = 24
        
        // Convenience aliases
        static let sm = small
        static let md = medium
        static let lg = large
        static let xl = xlarge
        static let xxl: CGFloat = 48
    }
    
    // MARK: - Component Sizes (Larger for better touch)
    enum ComponentSize {
        // Button heights (larger than standard)
        static let buttonHeight: CGFloat = 56
        static let buttonSmallHeight: CGFloat = 44
        
        // Input heights
        static let inputHeight: CGFloat = 56
        
        // Search bar
        static let searchBarHeight: CGFloat = 56
        
        // Tab bar (taller for custom design)
        static let tabBarHeight: CGFloat = 80
        
        // Navigation bar
        static let navBarHeight: CGFloat = 44
        
        // Avatar sizes
        static let avatarSmall: CGFloat = 32
        static let avatarMedium: CGFloat = 40
        static let avatarLarge: CGFloat = 64
        static let avatarXLarge: CGFloat = 96
        
        // Minimum touch target
        static let minTouchTarget: CGFloat = 44
        
        // Icon button
        static let iconButton: CGFloat = 48
    }
}

// MARK: - View Extensions for Unique Design (Monika Custom)
extension View {
    /// Standard card with colored shadow
    func cardStyle() -> some View {
        self
            .background(DesignTokens.Colors.white)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(DesignTokens.Shadow.card.opacity),
                radius: DesignTokens.Shadow.card.radius,
                x: DesignTokens.Shadow.card.x,
                y: DesignTokens.Shadow.card.y
            )
    }
    
    /// Elevated card with stronger colored shadow
    func elevatedCardStyle() -> some View {
        self
            .background(DesignTokens.Colors.white)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(DesignTokens.Shadow.large.opacity),
                radius: DesignTokens.Shadow.large.radius,
                x: DesignTokens.Shadow.large.x,
                y: DesignTokens.Shadow.large.y
            )
    }
    
    /// Glass morphism card
    func glassCardStyle() -> some View {
        self
            .background(
                DesignTokens.Colors.white.opacity(0.7)
                    .background(.ultraThinMaterial)
            )
            .cornerRadius(DesignTokens.BorderRadius.card)
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.BorderRadius.card)
                    .stroke(DesignTokens.Colors.white.opacity(0.3), lineWidth: 1)
            )
    }
    
    /// Gradient card
    func gradientCardStyle() -> some View {
        self
            .background(DesignTokens.Gradients.primary)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(0.3),
                radius: 20,
                x: 0,
                y: 4
            )
    }
    
    /// Primary button with gradient
    func primaryButtonStyle() -> some View {
        self
            .frame(height: DesignTokens.ComponentSize.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(DesignTokens.Gradients.primary)
            .foregroundColor(DesignTokens.Colors.white)
            .cornerRadius(DesignTokens.BorderRadius.button)
            .font(DesignTokens.Typography.headline)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(DesignTokens.Shadow.colored.opacity),
                radius: DesignTokens.Shadow.colored.radius,
                x: DesignTokens.Shadow.colored.x,
                y: DesignTokens.Shadow.colored.y
            )
    }
    
    /// Secondary button with subtle background
    func secondaryButtonStyle() -> some View {
        self
            .frame(height: DesignTokens.ComponentSize.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(DesignTokens.Colors.primarySubtle)
            .foregroundColor(DesignTokens.Colors.primary)
            .cornerRadius(DesignTokens.BorderRadius.button)
            .font(DesignTokens.Typography.headline)
    }
    
    /// Outline button
    func outlineButtonStyle() -> some View {
        self
            .frame(height: DesignTokens.ComponentSize.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .foregroundColor(DesignTokens.Colors.primary)
            .cornerRadius(DesignTokens.BorderRadius.button)
            .font(DesignTokens.Typography.headline)
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.BorderRadius.button)
                    .stroke(DesignTokens.Colors.primary, lineWidth: 2)
            )
    }
    
    /// Gradient text
    func gradientForeground() -> some View {
        self.overlay(DesignTokens.Gradients.primary)
            .mask(self)
    }
    
    /// Adaptive background that changes with color scheme
    func adaptiveBackground(_ colorScheme: ColorScheme) -> some View {
        self.background(
            colorScheme == .dark 
                ? DesignTokens.Gradients.backgroundDark 
                : DesignTokens.Gradients.backgroundLight
        )
    }
    
    /// Calendar-specific adaptive background
    func calendarBackground(_ colorScheme: ColorScheme) -> some View {
        self.background(
            colorScheme == .dark 
                ? DesignTokens.Gradients.backgroundDarkCalendar
                : DesignTokens.Gradients.backgroundLightCalendar
        )
    }
    
    /// People-specific adaptive background
    func peopleBackground(_ colorScheme: ColorScheme) -> some View {
        self.background(
            colorScheme == .dark 
                ? DesignTokens.Gradients.backgroundDarkPeople
                : DesignTokens.Gradients.backgroundLightPeople
        )
    }
    
    /// Gifts-specific adaptive background
    func giftsBackground(_ colorScheme: ColorScheme) -> some View {
        self.background(
            colorScheme == .dark 
                ? DesignTokens.Gradients.backgroundDarkGifts
                : DesignTokens.Gradients.backgroundLightGifts
        )
    }
    
    /// Adaptive card background
    func adaptiveCardStyle(_ colorScheme: ColorScheme) -> some View {
        self
            .background(colorScheme == .dark ? DesignTokens.Colors.surfaceDark : DesignTokens.Colors.surface)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: (colorScheme == .dark ? DesignTokens.Colors.primary.opacity(0.3) : DesignTokens.Colors.primary.opacity(DesignTokens.Shadow.card.opacity)),
                radius: DesignTokens.Shadow.card.radius,
                x: DesignTokens.Shadow.card.x,
                y: DesignTokens.Shadow.card.y
            )
    }
}

// MARK: - Adaptive Color Helpers
extension DesignTokens.Colors {
    /// Returns adaptive text primary color based on color scheme
    static func adaptiveTextPrimary(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? textPrimaryDark : textPrimary
    }
    
    /// Returns adaptive text secondary color based on color scheme
    static func adaptiveTextSecondary(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? textSecondaryDark : textSecondary
    }
    
    /// Returns adaptive text tertiary color based on color scheme
    static func adaptiveTextTertiary(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? textTertiaryDark : textTertiary
    }
    
    /// Returns adaptive surface color based on color scheme
    static func adaptiveSurface(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? surfaceDark : surface
    }
    
    /// Returns adaptive background color based on color scheme
    static func adaptiveBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? backgroundDark : background
    }
}

