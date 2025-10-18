import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var fullWidth: Bool = true
    
    @State private var isPressed = false
    @State private var rotationAngle: Double = 0
    
    init(
        _ title: String,
        icon: String? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        fullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.fullWidth = fullWidth
        self.action = action
    }
    
    var body: some View {
        Button(action: handleAction) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: DesignTokens.IconSize.sm, weight: .semibold))
                            .rotationEffect(.degrees(rotationAngle))
                    }
                    Text(title)
                        .font(DesignTokens.Typography.labelLarge)
                }
            }
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .frame(height: DesignTokens.ComponentSize.buttonHeight)
            .padding(.horizontal, DesignTokens.Spacing.xl)
            .background(
                Group {
                    if isDisabled {
                        DesignTokens.Colors.slate400
                    } else {
                        DesignTokens.Gradients.primary
                    }
                }
            )
            .foregroundColor(.white)
            .cornerRadius(DesignTokens.BorderRadius.button)
            .shadow(
                color: isDisabled ? .clear : DesignTokens.Colors.primary.opacity(isPressed ? 0.1 : 0.2),
                radius: isPressed ? 8 : 16,
                x: 0,
                y: isPressed ? 2 : 4
            )
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .rotationEffect(.degrees(isPressed ? (Double.random(in: -0.5...0.5)) : 0))
        }
        .disabled(isDisabled || isLoading)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(AnimationConstants.quick) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(AnimationConstants.bouncy) {
                        isPressed = false
                    }
                }
        )
    }
    
    private func handleAction() {
        // Icon spin animation on tap
        if icon != nil {
            withAnimation(AnimationConstants.bouncy) {
                rotationAngle += 360
            }
        }
        
        #if os(iOS)
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        #endif
        
        action()
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton("Save", icon: "checkmark") { }
        PrimaryButton("Loading", isLoading: true) { }
        PrimaryButton("Disabled", isDisabled: true) { }
        PrimaryButton("Not Full Width", fullWidth: false) { }
    }
    .padding()
}

