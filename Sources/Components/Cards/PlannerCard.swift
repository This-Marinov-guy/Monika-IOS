import SwiftUI

struct PlannerCard<Content: View>: View {
    let content: Content
    var padding: CGFloat = DesignTokens.Spacing.md
    var elevated: Bool = false
    
    init(padding: CGFloat = DesignTokens.Spacing.md, elevated: Bool = false, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.elevated = elevated
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(DesignTokens.Colors.white)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(elevated ? DesignTokens.Shadow.large.opacity : DesignTokens.Shadow.card.opacity),
                radius: elevated ? DesignTokens.Shadow.large.radius : DesignTokens.Shadow.card.radius,
                x: elevated ? DesignTokens.Shadow.large.x : DesignTokens.Shadow.card.x,
                y: elevated ? DesignTokens.Shadow.large.y : DesignTokens.Shadow.card.y
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        PlannerCard {
            Text("Standard Card")
                .frame(maxWidth: .infinity)
        }
        
        PlannerCard(elevated: true) {
            Text("Elevated Card")
                .frame(maxWidth: .infinity)
        }
    }
    .padding()
    .background(Color.adaptiveBackground)
}

