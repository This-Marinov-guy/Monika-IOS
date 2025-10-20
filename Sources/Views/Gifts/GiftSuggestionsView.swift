import SwiftUI

public struct GiftSuggestionsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    public init() {}
    
    private let suggestions: [Suggestion] = [
        .init(title: "Roses Bouquet", tag: "Popular"),
        .init(title: "Artisanal Chocolates", tag: "Surprise"),
        .init(title: "Scented Candles", tag: "Budget"),
        .init(title: "Spa Voucher", tag: "Popular"),
        .init(title: "Custom Mug", tag: "Budget"),
        .init(title: "Handwritten Letter", tag: "Surprise")
    ]
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: DesignTokens.Spacing.medium)], spacing: DesignTokens.Spacing.medium) {
                ForEach(suggestions) { item in
                    PlannerCard {
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(DesignTokens.Colors.primary.opacity(0.08))
                                .frame(height: 100)
                                .overlay(alignment: .topLeading) {
                                    TagPill(text: item.tag)
                                        .padding(8)
                                }
                            Text(item.title)
                                .font(DesignTokens.Typography.body)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                            HStack {
                                Button("Add to Reminder") {}
                                    .primaryButtonStyle()
                            }
                        }
                    }
                }
            }
            .padding(DesignTokens.Spacing.screenPadding)
        }
        .navigationTitle("Suggestions")
    }
}

private struct Suggestion: Identifiable {
    let id = UUID()
    let title: String
    let tag: String
}

private struct TagPill: View {
    @Environment(\.colorScheme) private var colorScheme
    let text: String
    
    var body: some View {
        Text(text)
            .font(DesignTokens.Typography.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        colorScheme == .dark
                        ? DesignTokens.Colors.accentDark.opacity(0.2)
                        : DesignTokens.Colors.accentSubtle
                    )
            )
            .foregroundStyle(
                colorScheme == .dark
                ? DesignTokens.Colors.accentDark
                : DesignTokens.Colors.accent
            )
    }
}

#Preview {
    NavigationStack { GiftSuggestionsView() }
}


