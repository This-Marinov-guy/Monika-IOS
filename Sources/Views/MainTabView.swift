import SwiftUI

public struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager
    
    public init() {}
    
    public var body: some View {
        TabView {
            CalendarTabView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            PeopleListView()
                .tabItem {
                    Label("People", systemImage: "person.2.fill")
                }
            
            GiftsListView()
                .tabItem {
                    Label("Gifts", systemImage: "gift.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        #if os(iOS)
        .tint(DesignTokens.Colors.primary)
        #endif
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthService())
        .environmentObject(ThemeManager())
}

