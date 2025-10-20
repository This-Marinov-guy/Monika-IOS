import SwiftUI

public struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Home Dashboard
            HomeDashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            // Gift Reminders (Primary Flow)
            RemindersView()
                .tabItem {
                    Label("Reminders", systemImage: "gift.fill")
                }
                .tag(1)
            
            // Calendar
            CalendarTabView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(2)
            
            // Profile
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(3)
        }
        #if os(iOS)
        .tint(DesignTokens.Colors.primary)
        #endif
        .onChange(of: selectedTab) { _ in
            // Haptic feedback on tab change
            #if os(iOS)
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            #endif
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthService())
        .environmentObject(ThemeManager())
}
