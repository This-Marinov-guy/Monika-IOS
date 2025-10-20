import SwiftUI

public struct RemindersView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var viewModel = GiftsViewModel()
    @State private var showingReminderForm = false
    @State private var showingSuggestions = false
    @State private var filterOption: FilterType = .upcoming
    
    public init() {}
    
    enum FilterType: String, CaseIterable {
        case upcoming = "Upcoming"
        case all = "All"
        case sent = "Sent"
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Background
                (colorScheme == .dark
                 ? DesignTokens.Gradients.backgroundDarkGifts
                 : DesignTokens.Gradients.backgroundLightGifts)
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Filter/Segment Control
                    VStack(spacing: 0) {
                        Picker("Filter", selection: $filterOption) {
                            ForEach(FilterType.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    .background(
                        LinearGradient(
                            colors: colorScheme == .dark
                                ? [DesignTokens.Colors.primaryDark.opacity(0.2), DesignTokens.Colors.backgroundDarkSecondary]
                                : [DesignTokens.Colors.primarySubtle.opacity(0.4), DesignTokens.Colors.white],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    ScrollView {
                        VStack(spacing: DesignTokens.Spacing.large) {
                            // Header with playful copy
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(MonikaStrings.Reminders.header)
                                        .font(DesignTokens.Typography.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                    Text(MonikaStrings.Reminders.subheader)
                                        .font(DesignTokens.Typography.callout)
                                        .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                                }
                                Spacer()
                            }
                            .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                            .padding(.top, DesignTokens.Spacing.base)
                            
                            // Reminders List by Person
                            VStack(spacing: DesignTokens.Spacing.large) {
                                ReminderPersonGroup(
                                    person: "Mom",
                                    reminders: [
                                        .init(name: "Flowers Bouquet", daysUntil: 3, sent: false),
                                        .init(name: "Handwritten Card", daysUntil: 3, sent: false)
                                    ]
                                )
                                
                                ReminderPersonGroup(
                                    person: "Alex",
                                    reminders: [
                                        .init(name: "Dinner Reservation", daysUntil: 7, sent: false)
                                    ]
                                )
                            }
                            .padding(.horizontal, DesignTokens.Spacing.screenPadding)
                            
                            // Empty state
                            if false { // Will connect to real data
                                VStack(spacing: DesignTokens.Spacing.lg) {
                                    Text(MonikaStrings.Reminders.emptyIcon)
                                        .font(.system(size: 64))
                                    Text(MonikaStrings.Reminders.emptyTitle)
                                        .font(DesignTokens.Typography.title3)
                                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                                    Text(MonikaStrings.Reminders.emptyMessage)
                                        .font(DesignTokens.Typography.body)
                                        .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(DesignTokens.Spacing.xl)
                            }
                        }
                        .padding(.bottom, 80) // Space for FAB
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton {
                            showingReminderForm = true
                        }
                        .padding(DesignTokens.Spacing.large)
                    }
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSuggestions = true
                    } label: {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(DesignTokens.Colors.secondary)
                    }
                }
            }
            .sheet(isPresented: $showingReminderForm) {
                GiftFormSheet()
            }
            .sheet(isPresented: $showingSuggestions) {
                NavigationStack {
                    GiftSuggestionsView()
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct ReminderItem: Identifiable {
    let id = UUID()
    let name: String
    let daysUntil: Int
    let sent: Bool
}

struct ReminderPersonGroup: View {
    @Environment(\.colorScheme) private var colorScheme
    let person: String
    let reminders: [ReminderItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.small) {
            Text(person)
                .font(DesignTokens.Typography.headline)
                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
            
            ForEach(reminders) { reminder in
                HStack(spacing: DesignTokens.Spacing.medium) {
                    // Icon
                    ZStack {
                        Circle()
                            .fill(reminder.sent ? DesignTokens.Colors.success.opacity(0.15) : DesignTokens.Colors.primary.opacity(0.15))
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: reminder.sent ? "checkmark.circle.fill" : "gift.fill")
                            .foregroundStyle(reminder.sent ? DesignTokens.Colors.success : DesignTokens.Colors.primary)
                    }
                    
                    // Details
                    VStack(alignment: .leading, spacing: 4) {
                        Text(reminder.name)
                            .font(DesignTokens.Typography.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                            .strikethrough(reminder.sent)
                        
                        Text(reminder.sent ? "Sent" : "In \(reminder.daysUntil) days")
                            .font(DesignTokens.Typography.caption)
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
                }
                .padding(DesignTokens.Spacing.base)
                .panelBackground(colorScheme)
                .cornerRadius(DesignTokens.BorderRadius.card)
                .shadow(
                    color: DesignTokens.Colors.primary.opacity(0.08),
                    radius: 8,
                    x: 0,
                    y: 2
                )
            }
        }
    }
}

#Preview {
    RemindersView()
        .environmentObject(ThemeManager())
}

