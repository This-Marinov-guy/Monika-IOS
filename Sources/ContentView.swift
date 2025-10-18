import SwiftUI

public struct ContentView: View {
    @EnvironmentObject var authService: AuthService
    @State private var showingAuth = false
    @State private var showSplash = true
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Main content
            Group {
                if authService.isAuthenticated {
                    MainTabView()
                } else {
                    WelcomeView(showingAuth: $showingAuth)
                }
            }
            .sheet(isPresented: $showingAuth) {
                AuthContainerView()
            }
            
            // Splash screen overlay
            if showSplash {
                SplashScreenView(isShowing: $showSplash)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

struct WelcomeView: View {
    @Binding var showingAuth: Bool
    @State private var iconRotation: Double = 0
    @State private var iconScale: CGFloat = 0.8
    @State private var floatingOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Animated gradient background
            AnimatedGradientBackground()
                .ignoresSafeArea()
            
            // Floating particles
            FloatingParticles()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Floating flower icon
                FlowerIcon()
                    .frame(width: 100, height: 100)
                    .scaleEffect(iconScale)
                    .rotationEffect(.degrees(iconRotation))
                    .offset(y: floatingOffset)
                    .shadow(color: Color(hex: "52B788").opacity(0.4), radius: 20, x: 0, y: 10)
                
                // Title with animation
                VStack(spacing: 12) {
                    Text("Monika Planner")
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, Color.white.opacity(0.8)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .slideInFromTop(delay: 0.3)
                    
                    Text("Plan your special moments")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .slideInFromTop(delay: 0.5)
                }
                
                Spacer()
                
                // Auth buttons with sequential animation
                VStack(spacing: 16) {
                    Button {
                        withAnimation(AnimationConstants.bouncy) {
                            showingAuth = true
                        }
                    } label: {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .foregroundColor(Color(hex: "40916C"))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 8)
                    }
                    .bouncyPressEffect()
                    .scaleOnAppear(delay: 0.7)
                    
                    Button {
                        withAnimation(AnimationConstants.bouncy) {
                            showingAuth = true
                        }
                    } label: {
                        Text("I already have an account")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .bouncyPressEffect()
                    .scaleOnAppear(delay: 0.9)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Subtle rotation
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            iconRotation = 5
        }
        
        // Scale pulse
        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
            iconScale = 1.0
        }
        
        // Floating effect
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
            floatingOffset = -15
        }
    }
}

// Animated gradient background
struct AnimatedGradientBackground: View {
    @State private var animate = false
    
    var body: some View {
        LinearGradient(
            colors: [
                Color(hex: "52B788"),
                Color(hex: "40916C"),
                Color(hex: "2D6A4F")
            ],
            startPoint: animate ? .topLeading : .bottomLeading,
            endPoint: animate ? .bottomTrailing : .topTrailing
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}

// Floating particles effect
struct FloatingParticles: View {
    @State private var particles: [Particle] = []
    
    struct Particle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var scale: CGFloat
        var opacity: Double
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white.opacity(particle.opacity))
                    .frame(width: 4 * particle.scale, height: 4 * particle.scale)
                    .position(x: particle.x, y: particle.y)
            }
        }
        .onAppear {
            generateParticles()
        }
    }
    
    private func generateParticles() {
        for _ in 0..<15 {
            let particle = Particle(
                x: CGFloat.random(in: 0...400),
                y: CGFloat.random(in: 0...800),
                scale: CGFloat.random(in: 0.5...2.0),
                opacity: Double.random(in: 0.1...0.3)
            )
            particles.append(particle)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
}


