import SwiftUI

public struct ProfileView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showingSignOutAlert = false
    
    public init() {}
    
    public var body: some View {
        List {
            // User info section
            Section {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if let email = authService.currentUser?.email {
                            Text(email)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.leading, 10)
                }
                .padding(.vertical, 10)
            }
            
            // User ID section
            if let userId = authService.currentUser?.id {
                Section("Account Details") {
                    HStack {
                        Text("User ID")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(userId.uuidString.prefix(8) + "...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Appearance section
            Section("Appearance") {
                Toggle(isOn: $themeManager.isDarkMode) {
                    HStack {
                        Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                            .foregroundColor(DesignTokens.Colors.primary)
                        Text("Dark Mode")
                    }
                }
                .tint(DesignTokens.Colors.primary)
            }
            
            // About section
            Section("About") {
                HStack {
                    Text("Version")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("App")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Monika Swift Planner")
                        .foregroundColor(.secondary)
                }
            }
            
            // Actions section
            Section {
                Button(role: .destructive) {
                    showingSignOutAlert = true
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                }
            }
        }
        .navigationTitle("Profile")
    #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
    #endif
        .alert("Sign Out", isPresented: $showingSignOutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {
                Task {
                    await authService.signOut()
                }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AuthService())
    }
}

