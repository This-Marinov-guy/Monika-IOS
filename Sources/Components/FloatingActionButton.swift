import SwiftUI

public struct FloatingActionButton: View {
    let action: () -> Void
    let icon: String
    var isExpanded: Bool = false
    
    @State private var isPressed = false
    @State private var scale: CGFloat = 0
    @State private var rotation: Double = 0
    
    public init(
        icon: String = "plus",
        isExpanded: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.isExpanded = isExpanded
        self.action = action
    }
    
    public var body: some View {
        Button(action: handleAction) {
            ZStack {
                // Shadow circle
                Circle()
                    .fill(DesignTokens.Gradients.primary)
                    .frame(width: 60, height: 60)
                    .shadow(
                        color: DesignTokens.Colors.primary.opacity(isPressed ? 0.2 : 0.4),
                        radius: isPressed ? 10 : 20,
                        x: 0,
                        y: isPressed ? 4 : 8
                    )
                
                // Icon
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
            }
            .scaleEffect(scale * (isPressed ? 0.9 : 1.0))
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            withAnimation(AnimationConstants.spring) {
                scale = 1.0
            }
        }
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
        // Rotation animation
        withAnimation(AnimationConstants.bouncy) {
            rotation += 90
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
    VStack {
        Spacer()
        HStack {
            Spacer()
            FloatingActionButton(icon: "plus") {
                print("FAB tapped")
            }
            .padding()
        }
    }
}

