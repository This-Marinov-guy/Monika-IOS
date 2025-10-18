import SwiftUI

public struct SplashScreenView: View {
    @Binding var isShowing: Bool
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    @State private var opacity: Double = 0
    @State private var glowOpacity: Double = 0
    @State private var titleOffset: CGFloat = 50
    @State private var titleOpacity: Double = 0
    
    public init(isShowing: Binding<Bool>) {
        self._isShowing = isShowing
    }
    
    public var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(hex: "52B788"),
                    Color(hex: "40916C"),
                    Color(hex: "2D6A4F")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Animated flower icon
                ZStack {
                    // Glow effect
                    FlowerIcon()
                        .frame(width: 140, height: 140)
                        .opacity(glowOpacity * 0.5)
                        .blur(radius: 20)
                    
                    // Main icon
                    FlowerIcon()
                        .frame(width: 120, height: 120)
                        .opacity(opacity)
                }
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                
                // App name
                Text("Monika")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y: titleOffset)
                    .opacity(titleOpacity)
                
                Spacer()
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        // Icon scale and fade in
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
            scale = 1.0
            opacity = 1.0
        }
        
        // Icon rotation
        withAnimation(.easeInOut(duration: 1.0).delay(0.2)) {
            rotation = 360
        }
        
        // Glow pulse
        withAnimation(.easeInOut(duration: 1.5).delay(0.3).repeatForever(autoreverses: true)) {
            glowOpacity = 1.0
        }
        
        // Title slide up
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.6)) {
            titleOffset = 0
            titleOpacity = 1.0
        }
        
        // Dismiss splash screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.4)) {
                isShowing = false
            }
        }
    }
}

// Flower Icon Component
struct FlowerIcon: View {
    var body: some View {
        ZStack {
            // Center circle
            Circle()
                .fill(Color(hex: "74C69D"))
                .frame(width: 30, height: 30)
            
            // Four petals
            ForEach(0..<4) { index in
                Circle()
                    .fill(Color(hex: "52B788"))
                    .frame(width: 40, height: 40)
                    .offset(x: petalOffset(for: index).x, y: petalOffset(for: index).y)
            }
            
            // Petal connectors (white outlines)
            ForEach(0..<4) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(width: 8, height: 25)
                    .offset(x: connectorOffset(for: index).x, y: connectorOffset(for: index).y)
                    .rotationEffect(.degrees(Double(index) * 90))
            }
            
            // Center white circle
            Circle()
                .fill(Color.white)
                .frame(width: 18, height: 18)
        }
    }
    
    private func petalOffset(for index: Int) -> CGPoint {
        let angle = Double(index) * 90 * .pi / 180
        let distance: CGFloat = 35
        return CGPoint(
            x: cos(angle) * distance,
            y: sin(angle) * distance
        )
    }
    
    private func connectorOffset(for index: Int) -> CGPoint {
        let angle = Double(index) * 90 * .pi / 180
        let distance: CGFloat = 17
        return CGPoint(
            x: cos(angle) * distance,
            y: sin(angle) * distance
        )
    }
}

#Preview {
    SplashScreenView(isShowing: .constant(true))
}

