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
            .background(Color.adaptiveSurface)
            .cornerRadius(DesignTokens.BorderRadius.lg)
            .shadow(
                color: Color.black.opacity(elevated ? DesignTokens.Shadow.large.opacity : DesignTokens.Shadow.medium.opacity),
                radius: elevated ? DesignTokens.Shadow.large.radius : DesignTokens.Shadow.medium.radius,
                x: elevated ? DesignTokens.Shadow.large.x : DesignTokens.Shadow.medium.x,
                y: elevated ? DesignTokens.Shadow.large.y : DesignTokens.Shadow.medium.y
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

