import SwiftUI

/// Animation constants for consistent playful animations throughout the app
enum AnimationConstants {
    // Spring animations for bouncy feel
    static let spring = Animation.spring(response: 0.5, dampingFraction: 0.6)
    static let bouncy = Animation.spring(response: 0.3, dampingFraction: 0.5)
    static let superBouncy = Animation.spring(response: 0.25, dampingFraction: 0.4)
    
    // Smooth animations
    static let gentle = Animation.easeInOut(duration: 0.3)
    static let quick = Animation.easeInOut(duration: 0.15)
    static let slow = Animation.easeInOut(duration: 0.6)
    
    // Special effects
    static let celebration = Animation.spring(response: 0.4, dampingFraction: 0.6)
    static let pulse = Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)
    
    // Timing constants
    static let staggerDelay: Double = 0.05
    static let cardAppearDelay: Double = 0.1
}

