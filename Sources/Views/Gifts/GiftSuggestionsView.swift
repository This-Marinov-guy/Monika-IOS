import SwiftUI

public struct GiftSuggestionsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedCategory: Category = .all
    @State private var favorites: Set<UUID> = []
    
    public init() {}
    
    enum Category: String, CaseIterable {
        case all = "All"
        case popular = "Popular"
        case budget = "Budget"
        case surprise = "Surprise"
    }
    
    private let suggestions: [Suggestion] = [
        .init(title: "Roses Bouquet", category: "Popular", price: 45.00, imageIcon: "🌹"),
        .init(title: "Artisanal Chocolates", category: "Surprise", price: 28.00, imageIcon: "🍫"),
        .init(title: "Scented Candles", category: "Budget", price: 15.00, imageIcon: "🕯️"),
        .init(title: "Spa Voucher", category: "Popular", price: 89.00, imageIcon: "💆"),
        .init(title: "Custom Mug", category: "Budget", price: 12.00, imageIcon: "☕"),
        .init(title: "Handwritten Letter", category: "Surprise", price: 0.00, imageIcon: "💌"),
        .init(title: "Photo Frame", category: "Popular", price: 22.00, imageIcon: "🖼️"),
        .init(title: "Plant Pot", category: "Budget", price: 18.00, imageIcon: "🪴")
    ]
    
    private var filteredSuggestions: [Suggestion] {
        if selectedCategory == .all {
            return suggestions
        }
        return suggestions.filter { $0.category == selectedCategory.rawValue }
    }
    
    public var body: some View {
        ZStack {
            // Background
            (colorScheme == .dark
             ? DesignTokens.Gradients.backgroundDarkGifts
             : DesignTokens.Gradients.backgroundLightGifts)
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Category Filter
                VStack(spacing: 0) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                .background(
                    LinearGradient(
                        colors: colorScheme == .dark
                            ? [DesignTokens.Colors.primaryDark.opacity(0.2), DesignTokens.Colors.backgroundDarkSecondary]
                            : [DesignTokens.Colors.primarySubtle.opacity(0.4), DesignTokens.Colors.white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                ScrollView {
                    VStack(spacing: DesignTokens.Spacing.lg) {
                        // Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(MonikaStrings.Suggestions.header)
                                    .font(DesignTokens.Typography.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                Text(MonikaStrings.Suggestions.subheader)
                                    .font(DesignTokens.Typography.callout)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.top, DesignTokens.Spacing.base)
                        
                        // Suggestions Grid
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 160), spacing: DesignTokens.Spacing.medium)
                            ],
                            spacing: DesignTokens.Spacing.medium
                        ) {
                            ForEach(filteredSuggestions) { suggestion in
                                SuggestionCard(
                                    suggestion: suggestion,
                                    isFavorite: favorites.contains(suggestion.id)
                                ) {
                                    toggleFavorite(suggestion.id)
                                }
                            }
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.bottom, DesignTokens.Spacing.xl3)
                    }
                }
            }
        }
        .navigationTitle(MonikaStrings.Suggestions.navigationTitle)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    private func toggleFavorite(_ id: UUID) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
}

// MARK: - Models

struct Suggestion: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let price: Double
    let imageIcon: String
}

// MARK: - Components

struct SuggestionCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let suggestion: Suggestion
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image placeholder with icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                DesignTokens.Colors.primary.opacity(0.08),
                                DesignTokens.Colors.secondary.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 120)
                
                Text(suggestion.imageIcon)
                    .font(.system(size: 48))
                
                // Favorite heart
                VStack {
                    HStack {
                        Spacer()
                        Button(action: onFavoriteTap) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(isFavorite ? .red : DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                                .padding(8)
                                .background(
                                    Circle()
                                        .fill(colorScheme == .dark ? Color.black.opacity(0.5) : Color.white.opacity(0.9))
                                )
                        }
                        .padding(8)
                    }
                    Spacer()
                }
                
                // Category tag
                VStack {
                    Spacer()
                    HStack {
                        TagPill(text: suggestion.category)
                        Spacer()
                    }
                    .padding(8)
                }
            }
            
            // Details
            VStack(alignment: .leading, spacing: 8) {
                Text(suggestion.title)
                    .font(DesignTokens.Typography.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                    .lineLimit(2)
                
                if suggestion.price > 0 {
                    Text("$\(String(format: "%.0f", suggestion.price))")
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                } else {
                    Text("Free")
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundStyle(DesignTokens.Colors.green)
                }
            }
            .padding(DesignTokens.Spacing.base)
        }
        .background(
            colorScheme == .dark
                ? DesignTokens.Colors.surfaceDark
                : DesignTokens.Colors.white
        )
        .cornerRadius(DesignTokens.BorderRadius.card)
        .overlay(
            RoundedRectangle(cornerRadius: DesignTokens.BorderRadius.card)
                .stroke(
                    colorScheme == .dark
                        ? DesignTokens.Colors.borderDark
                        : DesignTokens.Colors.borderLight,
                    lineWidth: DesignTokens.BorderWidth.regular
                )
        )
        .shadow(
            color: DesignTokens.Colors.primary.opacity(0.08),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}

struct TagPill: View {
    @Environment(\.colorScheme) private var colorScheme
    let text: String
    
    private var color: Color {
        switch text {
        case "Popular": return DesignTokens.Colors.primary
        case "Budget": return DesignTokens.Colors.green
        case "Surprise": return DesignTokens.Colors.secondary
        default: return DesignTokens.Colors.accent
        }
    }
    
    var body: some View {
        Text(text)
            .font(DesignTokens.Typography.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.15))
            )
            .foregroundStyle(color)
    }
}

#Preview {
    NavigationStack {
        GiftSuggestionsView()
            .environmentObject(ThemeManager())
    }
}
