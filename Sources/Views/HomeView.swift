import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background per spec
                (colorScheme == .dark
                 ? DesignTokens.Gradients.backgroundDark
                 : DesignTokens.Gradients.backgroundLight)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DesignTokens.Spacing.xl) {
                        // Header
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                            Text("Hey, ready to make someone smile?")
                                .font(DesignTokens.Typography.largeTitle)
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                            if let email = authService.currentUser?.email {
                                Text(email)
                                    .font(DesignTokens.Typography.subheadline)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.top, DesignTokens.Spacing.xl)

                        // Upcoming events carousel (placeholder structure)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: DesignTokens.Spacing.medium) {
                                ForEach(0..<5, id: \.self) { idx in
                                    PlannerCard { 
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("Birthday • In \(3 + idx) days")
                                                .font(DesignTokens.Typography.subheadline)
                                                .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                                            Text("Jane Doe")
                                                .font(DesignTokens.Typography.title3)
                                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                        }
                                        .frame(width: 220, alignment: .leading)
                                    }
                                }
                            }
                            .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        }

                        // Motivational quote panel
                        PlannerCard {
                            HStack(spacing: DesignTokens.Spacing.medium) {
                                Text("A flower today keeps the frown away 🌷")
                                    .font(DesignTokens.Typography.callout)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)

                        // CTA
                        HStack {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Text("View Profile")
                                    .frame(maxWidth: .infinity)
                            }
                            .primaryButtonStyle()
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.bottom, DesignTokens.Spacing.xl2)
                    }
                }

                // Floating Action Button
                VStack { Spacer() 
                    HStack { Spacer()
                        FloatingActionButton(action: {})
                            .padding(DesignTokens.Spacing.large)
                    }
                }
            }
            .navigationTitle("Home")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthService())
}

