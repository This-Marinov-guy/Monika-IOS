import SwiftUI

extension View {
    // MARK: - Press Effects
    
    /// Bouncy press effect that scales the view down when pressed
    func bouncyPressEffect() -> some View {
        self.modifier(BouncyPressModifier())
    }
    
    // MARK: - Appear Animations
    
    /// Scale animation on appear
    func scaleOnAppear(delay: Double = 0) -> some View {
        self.modifier(ScaleOnAppearModifier(delay: delay))
    }
    
    /// Slide in from bottom
    func slideInFromBottom(delay: Double = 0) -> some View {
        self.modifier(SlideInModifier(edge: .bottom, delay: delay))
    }
    
    /// Slide in from left
    func slideInFromLeft(delay: Double = 0) -> some View {
        self.modifier(SlideInModifier(edge: .leading, delay: delay))
    }
    
    /// Slide in from right
    func slideInFromRight(delay: Double = 0) -> some View {
        self.modifier(SlideInModifier(edge: .trailing, delay: delay))
    }
    
    /// Slide in from top
    func slideInFromTop(delay: Double = 0) -> some View {
        self.modifier(SlideInModifier(edge: .top, delay: delay))
    }
    
    // MARK: - Effects
    
    /// Shimmer effect for loading states
    func shimmerEffect() -> some View {
        self.modifier(ShimmerModifier())
    }
    
    /// Shake animation for errors
    func shakeEffect(trigger: Bool) -> some View {
        self.modifier(ShakeModifier(trigger: trigger))
    }
    
    /// Pulse animation
    func pulseEffect() -> some View {
        self.modifier(PulseModifier())
    }
    
    /// Rotation animation
    func rotateOnAppear(delay: Double = 0) -> some View {
        self.modifier(RotateOnAppearModifier(delay: delay))
    }
}

// MARK: - Modifiers

struct BouncyPressModifier: ViewModifier {
    @State private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(AnimationConstants.bouncy, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}

struct ScaleOnAppearModifier: ViewModifier {
    let delay: Double
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible ? 1.0 : 0.5)
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(AnimationConstants.spring.delay(delay)) {
                    isVisible = true
                }
            }
    }
}

struct SlideInModifier: ViewModifier {
    let edge: Edge
    let delay: Double
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .offset(offset)
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(AnimationConstants.spring.delay(delay)) {
                    isVisible = true
                }
            }
    }
    
    private var offset: CGSize {
        if isVisible { return .zero }
        switch edge {
        case .top: return CGSize(width: 0, height: -50)
        case .bottom: return CGSize(width: 0, height: 50)
        case .leading: return CGSize(width: -50, height: 0)
        case .trailing: return CGSize(width: 50, height: 0)
        }
    }
}

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        .clear,
                        .white.opacity(0.3),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }
}

struct ShakeModifier: ViewModifier {
    let trigger: Bool
    @State private var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .onChange(of: trigger) { newValue in
                if newValue {
                    shake()
                }
            }
    }
    
    private func shake() {
        let sequence: [CGFloat] = [0, -10, 10, -10, 10, -5, 5, 0]
        for (index, value) in sequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                offset = value
            }
        }
    }
}

struct PulseModifier: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .animation(AnimationConstants.pulse, value: isPulsing)
            .onAppear {
                isPulsing = true
            }
    }
}

struct RotateOnAppearModifier: ViewModifier {
    let delay: Double
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isVisible ? 0 : -180))
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(AnimationConstants.spring.delay(delay)) {
                    isVisible = true
                }
            }
    }
}

