import SwiftUI

public struct HomeDashboardView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var authService: AuthService
    @State private var showingAddReminder = false
    
    public init() {}
    
    // Sample upcoming reminders (will connect to real data)
    private let upcomingReminders = [
        ReminderPreview(person: "Mom", occasion: "Birthday", daysUntil: 3, emoji: "🎂"),
        ReminderPreview(person: "Alex", occasion: "Anniversary", daysUntil: 7, emoji: "💕"),
        ReminderPreview(person: "Sarah", occasion: "Custom", daysUntil: 14, emoji: "🎁")
    ]
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Playful gradient background
                (colorScheme == .dark
                 ? DesignTokens.Gradients.backgroundDark
                 : DesignTokens.Gradients.backgroundLight)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DesignTokens.Spacing.xl) {
                        // Playful Header
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                            HStack {
                                Text(MonikaStrings.Home.header)
                                    .font(DesignTokens.Typography.largeTitle)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                Spacer()
                                Text(MonikaStrings.Home.headerEmoji)
                                    .font(.system(size: 36))
                            }
                            Text("You have \(upcomingReminders.count) upcoming reminders")
                                .font(DesignTokens.Typography.body)
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.top, DesignTokens.Spacing.lg)
                        
                        // Upcoming Reminders Carousel
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.medium) {
                            Text("Upcoming")
                                .font(DesignTokens.Typography.headline)
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: DesignTokens.Spacing.medium) {
                                    ForEach(upcomingReminders) { reminder in
                                        ReminderCard(reminder: reminder)
                                    }
                                }
                                .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                            }
                        }
                        
                        // Motivational Quote Panel
                        VStack(spacing: 0) {
                            HStack {
                                Text(MonikaStrings.Home.quoteEmoji)
                                    .font(.system(size: 28))
                                Text(MonikaStrings.Home.motivationalQuote)
                                    .font(DesignTokens.Typography.callout)
                                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                Spacer()
                            }
            .padding(DesignTokens.Spacing.base)
            .panelBackgroundWithBorder(colorScheme)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.primary.opacity(0.1),
                radius: 12,
                x: 0,
                y: 4
            )
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        
                        // Quick Actions
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.medium) {
                            Text("Quick Actions")
                                .font(DesignTokens.Typography.headline)
                                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                            
                            VStack(spacing: DesignTokens.Spacing.medium) {
                                QuickActionButton(
                                    icon: "gift.fill",
                                    title: MonikaStrings.Actions.scheduleGift,
                                    subtitle: MonikaStrings.Actions.scheduleGiftSubtitle
                                ) {
                                    showingAddReminder = true
                                }
                                
                                NavigationLink {
                                    GiftSuggestionsView()
                                } label: {
                                    QuickActionButtonContent(
                                        icon: "sparkles",
                                        title: MonikaStrings.Actions.browseSuggestions,
                                        subtitle: MonikaStrings.Actions.browseSuggestionsSubtitle
                                    )
                                }
                                
                                NavigationLink {
                                    PeopleListView()
                                } label: {
                                    QuickActionButtonContent(
                                        icon: "person.2.fill",
                                        title: MonikaStrings.Actions.managePeople,
                                        subtitle: MonikaStrings.Actions.managePeopleSubtitle
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                        .padding(.bottom, DesignTokens.Spacing.xl3)
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton {
                            showingAddReminder = true
                        }
                        .padding(DesignTokens.Spacing.large)
                    }
                }
            }
            .navigationTitle("Monika")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .sheet(isPresented: $showingAddReminder) {
                // Will show gift reminder form
                Text("Add Reminder Form (Coming Soon)")
            }
        }
    }
}

// MARK: - Supporting Views

struct ReminderPreview: Identifiable {
    let id = UUID()
    let person: String
    let occasion: String
    let daysUntil: Int
    let emoji: String
}

struct ReminderCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let reminder: ReminderPreview
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack {
                Text(reminder.emoji)
                    .font(.system(size: 32))
                Spacer()
                Text("\(reminder.daysUntil)d")
                    .font(DesignTokens.Typography.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignTokens.Colors.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(DesignTokens.Colors.primary.opacity(0.15))
                    )
            }
            
            Text(reminder.occasion)
                .font(DesignTokens.Typography.caption)
                .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
            
            Text(reminder.person)
                .font(DesignTokens.Typography.title3)
                .fontWeight(.semibold)
                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
        }
        .frame(width: 160)
        .padding(DesignTokens.Spacing.base)
        .panelBackgroundWithBorder(colorScheme)
        .cornerRadius(DesignTokens.BorderRadius.card)
        .shadow(
            color: DesignTokens.Colors.primary.opacity(0.12),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}

struct QuickActionButton: View {
    @Environment(\.colorScheme) private var colorScheme
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            QuickActionButtonContent(icon: icon, title: title, subtitle: subtitle)
        }
    }
}

struct QuickActionButtonContent: View {
    @Environment(\.colorScheme) private var colorScheme
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: DesignTokens.Spacing.medium) {
            ZStack {
                Circle()
                    .fill(DesignTokens.Gradients.primary)
                    .frame(width: 50, height: 50)
                    .shadow(color: DesignTokens.Colors.primary.opacity(0.3), radius: 8, x: 0, y: 4)
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(DesignTokens.Typography.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                
                Text(subtitle)
                    .font(DesignTokens.Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
        }
        .padding(DesignTokens.Spacing.base)
        .panelBackgroundWithBorder(colorScheme)
        .cornerRadius(DesignTokens.BorderRadius.card)
        .shadow(
            color: DesignTokens.Colors.primary.opacity(0.08),
            radius: 8,
            x: 0,
            y: 2
        )
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(AuthService())
        .environmentObject(ThemeManager())
}

