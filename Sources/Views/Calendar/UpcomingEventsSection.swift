import SwiftUI

struct UpcomingEventsSection: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.medium) {
            HStack {
                Text(MonikaStrings.Calendar.upcomingEvents)
                    .font(DesignTokens.Typography.headline)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                
                Spacer()
                
                Button("See All") {
                    // TODO: Show all events
                }
                .font(DesignTokens.Typography.subheadline)
                .foregroundStyle(DesignTokens.Colors.primary)
            }
            
            VStack(spacing: DesignTokens.Spacing.small) {
                // Placeholder events
                EventRow(
                    title: "Birthday Party",
                    date: Date(),
                    category: "Birthday",
                    personName: "John Doe"
                )
                
                EventRow(
                    title: "Anniversary",
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
                    category: "Anniversary",
                    personName: "Jane Smith"
                )
                
                // Empty state when no events
                if false {
                    EmptyState(
                        icon: "calendar.badge.exclamationmark",
                        title: "No upcoming events",
                        message: "Add your first event to get started"
                    )
                }
            }
        }
    }
}

struct EventRow: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let date: Date
    let category: String
    let personName: String?
    
    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: DesignTokens.Spacing.medium) {
                // Date indicator
                VStack(spacing: 2) {
                    Text(dateText.components(separatedBy: " ")[1])
                        .font(DesignTokens.Typography.title)
                        .fontWeight(.bold)
                        .foregroundStyle(isToday ? DesignTokens.Colors.primary : DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                    
                    Text(dateText.components(separatedBy: " ")[0].uppercased())
                        .font(DesignTokens.Typography.caption)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                }
                .frame(width: 50)
                
                // Event details
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(DesignTokens.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                    
                    HStack(spacing: DesignTokens.Spacing.small) {
                        Label(category, systemImage: "tag.fill")
                        
                        if let personName = personName {
                            Label(personName, systemImage: "person.fill")
                        }
                    }
                    .font(DesignTokens.Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
            }
            .padding(DesignTokens.Spacing.base)
            .panelBackgroundGreen(colorScheme)
            .cornerRadius(DesignTokens.BorderRadius.card)
            .shadow(
                color: DesignTokens.Colors.green.opacity(0.12),
                radius: 12,
                x: 0,
                y: 4
            )
        }
    }
}

#Preview {
    UpcomingEventsSection()
        .padding()
}

