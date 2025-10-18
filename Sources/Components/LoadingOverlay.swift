import SwiftUI

public struct LoadingOverlay: View {
    @State private var rotation: Double = 0
    @State private var dot1Scale: CGFloat = 1.0
    @State private var dot2Scale: CGFloat = 1.0
    @State private var dot3Scale: CGFloat = 1.0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Blur background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .blur(radius: 10)
            
            // Loading content
            VStack(spacing: DesignTokens.Spacing.large) {
                // Spinning flower petals
                ZStack {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(DesignTokens.Colors.primary.opacity(0.8))
                            .frame(width: 20, height: 20)
                            .offset(x: 25)
                            .rotationEffect(.degrees(Double(index) * 90 + rotation))
                    }
                    
                    Circle()
                        .fill(DesignTokens.Colors.accent)
                        .frame(width: 16, height: 16)
                }
                .frame(width: 70, height: 70)
                
                // Bouncing dots
                HStack(spacing: 8) {
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                        .frame(width: 12, height: 12)
                        .scaleEffect(dot1Scale)
                    
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                        .frame(width: 12, height: 12)
                        .scaleEffect(dot2Scale)
                    
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                        .frame(width: 12, height: 12)
                        .scaleEffect(dot3Scale)
                }
            }
            .padding(DesignTokens.Spacing.xl2)
            .background(
                RoundedRectangle(cornerRadius: DesignTokens.BorderRadius.xl)
                    .fill(.ultraThinMaterial)
            )
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Rotation animation
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            rotation = 360
        }
        
        // Bouncing dots
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
            dot1Scale = 0.5
        }
        
        withAnimation(.easeInOut(duration: 0.6).delay(0.2).repeatForever(autoreverses: true)) {
            dot2Scale = 0.5
        }
        
        withAnimation(.easeInOut(duration: 0.6).delay(0.4).repeatForever(autoreverses: true)) {
            dot3Scale = 0.5
        }
    }
}

public extension View {
    func loadingOverlay(isLoading: Bool) -> some View {
        ZStack {
            self
            
            if isLoading {
                LoadingOverlay()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        LoadingOverlay()
    }
}

