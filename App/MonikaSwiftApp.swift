import SwiftUI
import MonikaSwiftCore

@main
struct MonikaSwiftApp: App {
    @StateObject private var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
        }
    }
}
