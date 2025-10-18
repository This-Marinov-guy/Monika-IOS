import SwiftUI

public struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            CalendarTabView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0)
            
            PeopleListView()
                .tabItem {
                    Label("People", systemImage: "person.2.fill")
                }
                .tag(1)
            
            GiftsListView()
                .tabItem {
                    Label("Gifts", systemImage: "gift.fill")
                }
                .tag(2)
            
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

