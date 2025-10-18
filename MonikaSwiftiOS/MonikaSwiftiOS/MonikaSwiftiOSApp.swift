import SwiftUI
import MonikaSwiftCore

@main
struct MonikaSwiftiOSApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}

