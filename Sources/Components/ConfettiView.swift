import SwiftUI

/// Confetti celebration effect
public struct ConfettiView: View {
    let pieces: [ConfettiPiece]
    
    public init() {
        self.pieces = (0..<50).map { _ in
            ConfettiPiece(
                color: [
                    Color(hex: "6366F1"),
                    Color(hex: "EC4899"),
                    Color(hex: "52B788"),
                    Color(hex: "F59E0B"),
                    Color(hex: "10B981"),
                    Color(hex: "3B82F6")
                ].randomElement()!,
                x: CGFloat.random(in: 0...400),
                y: -20,
                rotation: Double.random(in: 0...360),
                scale: CGFloat.random(in: 0.5...1.5)
            )
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(pieces.indices, id: \.self) { index in
                    ConfettiPieceView(piece: pieces[index], geometry: geometry)
                }
            }
        }
        .allowsHitTesting(false)
    }
}

struct ConfettiPiece {
    let color: Color
    var x: CGFloat
    var y: CGFloat
    var rotation: Double
    var scale: CGFloat
}

struct ConfettiPieceView: View {
    let piece: ConfettiPiece
    let geometry: GeometryProxy
    
    @State private var yPosition: CGFloat
    @State private var xPosition: CGFloat
    @State private var rotation: Double
    @State private var opacity: Double = 1.0
    
    init(piece: ConfettiPiece, geometry: GeometryProxy) {
        self.piece = piece
        self.geometry = geometry
        _yPosition = State(initialValue: piece.y)
        _xPosition = State(initialValue: piece.x)
        _rotation = State(initialValue: piece.rotation)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(piece.color)
            .frame(width: 10 * piece.scale, height: 6 * piece.scale)
            .rotationEffect(.degrees(rotation))
            .position(x: xPosition, y: yPosition)
            .opacity(opacity)
            .onAppear {
                animatePiece()
            }
    }
    
    private func animatePiece() {
        let duration = Double.random(in: 1.5...2.5)
        let delay = Double.random(in: 0...0.3)
        let xVariation = CGFloat.random(in: -50...50)
        
        withAnimation(.easeIn(duration: duration).delay(delay)) {
            yPosition = geometry.size.height + 50
            xPosition = piece.x + xVariation
            rotation = piece.rotation + Double.random(in: 360...720)
            opacity = 0.0
        }
    }
}

// Confetti modifier
public struct CelebrationModifier: ViewModifier {
    let trigger: Bool
    @State private var showConfetti = false
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if showConfetti {
                        ConfettiView()
                            .transition(.opacity)
                    }
                }
            )
            .onChange(of: trigger) { newValue in
                if newValue {
                    celebrate()
                }
            }
    }
    
    private func celebrate() {
        showConfetti = true
        
        #if os(iOS)
        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        #endif
        
        // Hide confetti after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            showConfetti = false
        }
    }
}

extension View {
    public func celebrate(trigger: Bool) -> some View {
        self.modifier(CelebrationModifier(trigger: trigger))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ConfettiView()
    }
}

