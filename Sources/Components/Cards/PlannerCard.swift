import SwiftUI

struct PlannerCard<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: Content
    var padding: CGFloat = DesignTokens.Spacing.md
    var elevated: Bool = false
    var enableAnimation: Bool = true
    
    @State private var isPressed = false
    
    init(
        padding: CGFloat = DesignTokens.Spacing.md,
        elevated: Bool = false,
        enableAnimation: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.elevated = elevated
        self.enableAnimation = enableAnimation
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .panelBackground(colorScheme)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(shadowOpacity),
                radius: shadowRadius,
                x: 0,
                y: shadowY
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(enableAnimation ? AnimationConstants.bouncy : nil, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if enableAnimation {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        if enableAnimation {
                            isPressed = false
                        }
                    }
            )
    }
    
    private var shadowOpacity: Double {
        if isPressed {
            return elevated ? DesignTokens.Shadow.large.opacity * 0.5 : DesignTokens.Shadow.card.opacity * 0.5
        }
        return elevated ? DesignTokens.Shadow.large.opacity : DesignTokens.Shadow.card.opacity
    }
    
    private var shadowRadius: CGFloat {
        if isPressed {
            return elevated ? DesignTokens.Shadow.large.radius * 0.5 : DesignTokens.Shadow.card.radius * 0.5
        }
        return elevated ? DesignTokens.Shadow.large.radius : DesignTokens.Shadow.card.radius
    }
    
    private var shadowY: CGFloat {
        if isPressed {
            return elevated ? DesignTokens.Shadow.large.y * 0.5 : DesignTokens.Shadow.card.y * 0.5
        }
        return elevated ? DesignTokens.Shadow.large.y : DesignTokens.Shadow.card.y
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

