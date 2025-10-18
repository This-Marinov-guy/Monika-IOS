import SwiftUI

public struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showingSignOutAlert = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Adaptive background
            (colorScheme == .dark 
                ? DesignTokens.Gradients.backgroundDark
                : DesignTokens.Gradients.backgroundLight)
                .ignoresSafeArea()
            
            List {
                // User info section with gradient
                Section {
                    VStack(spacing: DesignTokens.Spacing.medium) {
                        // Avatar with gradient background and pulse
                        ZStack {
                            Circle()
                                .fill(DesignTokens.Gradients.primary)
                                .frame(width: 80, height: 80)
                                .shadow(
                                    color: DesignTokens.Colors.primary.opacity(0.3),
                                    radius: 20,
                                    x: 0,
                                    y: 4
                                )
                            
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 70))
                                .foregroundColor(.white)
                        }
                        .pulseEffect()
                        .scaleOnAppear(delay: 0.2)
                        
                        VStack(spacing: 4) {
                            Text("Email")
                                .font(DesignTokens.Typography.caption)
                                .foregroundColor(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                            
                            if let email = authService.currentUser?.email {
                                Text(email)
                                    .font(DesignTokens.Typography.body)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DesignTokens.Spacing.large)
                    .listRowBackground(
                        colorScheme == .dark 
                            ? DesignTokens.Gradients.dark.opacity(0.3)
                            : DesignTokens.Gradients.subtle.opacity(0.5)
                    )
                }
            
                // User ID section
                if let userId = authService.currentUser?.id {
                    Section {
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundColor(DesignTokens.Colors.primary)
                                .frame(width: 24)
                            Text("User ID")
                                .foregroundColor(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                            Spacer()
                            Text(userId.uuidString.prefix(8) + "...")
                                .font(.caption)
                                .foregroundColor(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
                        }
                    } header: {
                        Text("Account Details")
                            .foregroundStyle(DesignTokens.Colors.textBrand)
                            .fontWeight(.semibold)
                    }
                    .listRowBackground(
                        colorScheme == .dark 
                            ? DesignTokens.Colors.surfaceDark
                            : DesignTokens.Colors.white
                    )
                }
                
                // Appearance section
                Section {
                    Toggle(isOn: $themeManager.isDarkMode.animation(AnimationConstants.bouncy)) {
                        HStack(spacing: DesignTokens.Spacing.medium) {
                            ZStack {
                                Circle()
                                    .fill(DesignTokens.Colors.primarySubtle)
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                                    .foregroundColor(DesignTokens.Colors.primary)
                                    .rotationEffect(.degrees(themeManager.isDarkMode ? 0 : 180))
                                    .animation(AnimationConstants.bouncy, value: themeManager.isDarkMode)
                            }
                            Text("Dark Mode")
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                        }
                    }
                    .tint(DesignTokens.Colors.primary)
                } header: {
                    Text("Appearance")
                        .foregroundStyle(DesignTokens.Colors.textBrand)
                        .fontWeight(.semibold)
                }
                .listRowBackground(
                    colorScheme == .dark 
                        ? DesignTokens.Colors.surfaceDark
                        : DesignTokens.Colors.white
                )
                
                // About section
                Section {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(DesignTokens.Colors.info)
                            .frame(width: 24)
                        Text("Version")
                            .foregroundColor(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
                    }
                    HStack {
                        Image(systemName: "app.fill")
                            .foregroundColor(DesignTokens.Colors.primary)
                            .frame(width: 24)
                        Text("App")
                            .foregroundColor(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                        Spacer()
                        Text("Monika Swift Planner")
                            .foregroundColor(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
                    }
                } header: {
                    Text("About")
                        .foregroundStyle(DesignTokens.Colors.textBrand)
                        .fontWeight(.semibold)
                }
                .listRowBackground(
                    colorScheme == .dark 
                        ? DesignTokens.Colors.surfaceDark
                        : DesignTokens.Colors.white
                )
                
                // Actions section
                Section {
                    Button(role: .destructive) {
                        showingSignOutAlert = true
                    } label: {
                        HStack(spacing: DesignTokens.Spacing.medium) {
                            ZStack {
                                Circle()
                                    .fill(Color.red.opacity(0.1))
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.red)
                            }
                            Text("Sign Out")
                        }
                    }
                }
                .listRowBackground(
                    colorScheme == .dark 
                        ? DesignTokens.Colors.surfaceDark
                        : DesignTokens.Colors.white
                )
            }
            .scrollContentBackground(.hidden)
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

