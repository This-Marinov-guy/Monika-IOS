import SwiftUI

public struct AnimatedEmptyState: View {
    let icon: String
    let title: String
    let message: String
    var action: (() -> Void)? = nil
    var actionTitle: String? = nil
    
    @State private var iconScale: CGFloat = 0.5
    @State private var iconRotation: Double = 0
    @State private var floatingOffset: CGFloat = 0
    @State private var textOpacity: Double = 0
    @State private var buttonScale: CGFloat = 0.5
    
    public init(
        icon: String,
        title: String,
        message: String,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action
        self.actionTitle = actionTitle
    }
    
    public var body: some View {
        VStack(spacing: DesignTokens.Spacing.xl) {
            // Animated icon
            ZStack {
                // Glow effect
                Image(systemName: icon)
                    .font(.system(size: 80))
                    .foregroundStyle(DesignTokens.Gradients.primary)
                    .opacity(0.3)
                    .blur(radius: 10)
                    .scaleEffect(iconScale * 1.1)
                
                // Main icon
                Image(systemName: icon)
                    .font(.system(size: 80))
                    .foregroundStyle(DesignTokens.Gradients.primary)
                    .scaleEffect(iconScale)
                    .rotationEffect(.degrees(iconRotation))
                    .offset(y: floatingOffset)
            }
            
            // Text content
            VStack(spacing: DesignTokens.Spacing.sm) {
                Text(title)
                    .font(DesignTokens.Typography.title1)
                    .fontWeight(.bold)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)
                    .opacity(textOpacity)
                
                Text(message)
                    .font(DesignTokens.Typography.body)
                    .foregroundStyle(DesignTokens.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .opacity(textOpacity)
            }
            .padding(.horizontal, DesignTokens.Spacing.xl)
            
            // Action button if provided
            if let action = action, let actionTitle = actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .font(DesignTokens.Typography.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, DesignTokens.Spacing.xl)
                        .padding(.vertical, DesignTokens.Spacing.md)
                        .background(DesignTokens.Gradients.primary)
                        .cornerRadius(DesignTokens.BorderRadius.button)
                }
                .scaleEffect(buttonScale)
                .bouncyPressEffect()
            }
        }
        .frame(maxWidth: 400)
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Icon scale and rotation
        withAnimation(AnimationConstants.spring.delay(0.1)) {
            iconScale = 1.0
        }
        
        withAnimation(AnimationConstants.gentle.delay(0.2)) {
            iconRotation = 360
        }
        
        // Floating animation
        withAnimation(.easeInOut(duration: 2.0).delay(0.4).repeatForever(autoreverses: true)) {
            floatingOffset = -10
        }
        
        // Text fade in
        withAnimation(AnimationConstants.gentle.delay(0.5)) {
            textOpacity = 1.0
        }
        
        // Button scale in
        withAnimation(AnimationConstants.spring.delay(0.7)) {
            buttonScale = 1.0
        }
    }
}

#Preview {
    AnimatedEmptyState(
        icon: "person.2.fill",
        title: "No people yet",
        message: "Add people to track their special days and never miss an important date",
        action: {},
        actionTitle: "Add Person"
    )
}

