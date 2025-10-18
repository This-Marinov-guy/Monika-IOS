import SwiftUI

enum DesignTokens {
    // MARK: - Colors
    enum Colors {
        static let primary = Color.appPrimary
        static let secondary = Color.gray
        static let background = Color.adaptiveBackground
        static let surface = Color.adaptiveSurface
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let textTertiary = Color.gray.opacity(0.6)
        static let error = Color.red
        static let success = Color.green
        static let warning = Color.orange
    }
    
    // MARK: - Spacing (8pt grid system)
    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
        static let xxxl: CGFloat = 64
        
        // Convenience aliases
        static let small = xs
        static let medium = md
        static let large = lg
    }
    
    // MARK: - Border Radius
    enum BorderRadius {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let full: CGFloat = 9999
    }
    
    // MARK: - Shadows
    enum Shadow {
        static let small = (radius: 2.0, x: 0.0, y: 1.0, opacity: 0.05)
        static let medium = (radius: 8.0, x: 0.0, y: 2.0, opacity: 0.08)
        static let large = (radius: 16.0, x: 0.0, y: 4.0, opacity: 0.12)
        static let xlarge = (radius: 24.0, x: 0.0, y: 8.0, opacity: 0.15)
    }
    
    // MARK: - Typography
    enum Typography {
        // Display
        static let displayLarge = Font.system(size: 57, weight: .bold)
        static let displayMedium = Font.system(size: 45, weight: .bold)
        static let displaySmall = Font.system(size: 36, weight: .bold)
        
        // Headline
        static let headlineLarge = Font.system(size: 32, weight: .semibold)
        static let headlineMedium = Font.system(size: 28, weight: .semibold)
        static let headlineSmall = Font.system(size: 24, weight: .semibold)
        
        // Title
        static let titleLarge = Font.system(size: 22, weight: .medium)
        static let titleMedium = Font.system(size: 16, weight: .medium)
        static let titleSmall = Font.system(size: 14, weight: .medium)
        
        // Body
        static let bodyLarge = Font.system(size: 16, weight: .regular)
        static let bodyMedium = Font.system(size: 14, weight: .regular)
        static let bodySmall = Font.system(size: 12, weight: .regular)
        
        // Label
        static let labelLarge = Font.system(size: 14, weight: .semibold)
        static let labelMedium = Font.system(size: 12, weight: .semibold)
        static let labelSmall = Font.system(size: 11, weight: .semibold)
        
        // Convenience aliases
        static let title = titleLarge
        static let headline = headlineMedium
        static let subheadline = titleSmall
        static let body = bodyMedium
        static let caption = labelSmall
    }
    
    // MARK: - Animation Durations
    enum Animation {
        static let fast: Double = 0.2
        static let normal: Double = 0.3
        static let slow: Double = 0.5
    }
    
    // MARK: - Icon Sizes
    enum IconSize {
        static let xs: CGFloat = 12
        static let sm: CGFloat = 16
        static let md: CGFloat = 20
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
}

// MARK: - View Extensions for Design Tokens
extension View {
    func cardStyle() -> some View {
        self
            .background(Color.adaptiveSurface)
            .cornerRadius(DesignTokens.BorderRadius.lg)
            .shadow(
                color: Color.black.opacity(DesignTokens.Shadow.medium.opacity),
                radius: DesignTokens.Shadow.medium.radius,
                x: DesignTokens.Shadow.medium.x,
                y: DesignTokens.Shadow.medium.y
            )
    }
    
    func elevatedCardStyle() -> some View {
        self
            .background(Color.adaptiveSurface)
            .cornerRadius(DesignTokens.BorderRadius.lg)
            .shadow(
                color: Color.black.opacity(DesignTokens.Shadow.large.opacity),
                radius: DesignTokens.Shadow.large.radius,
                x: DesignTokens.Shadow.large.x,
                y: DesignTokens.Shadow.large.y
            )
    }
    
    func primaryButtonStyle() -> some View {
        self
            .padding(.vertical, DesignTokens.Spacing.md)
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .background(Color.appPrimary)
            .foregroundColor(.white)
            .cornerRadius(DesignTokens.BorderRadius.md)
            .font(DesignTokens.Typography.labelLarge)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .padding(.vertical, DesignTokens.Spacing.md)
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .background(Color.adaptiveSecondaryBackground)
            .foregroundColor(.appPrimary)
            .cornerRadius(DesignTokens.BorderRadius.md)
            .font(DesignTokens.Typography.labelLarge)
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.BorderRadius.md)
                    .stroke(Color.appPrimary, lineWidth: 1.5)
            )
    }
}

