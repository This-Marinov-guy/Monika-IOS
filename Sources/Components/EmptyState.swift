import SwiftUI

struct EmptyState: View {
    let icon: String
    let title: String
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: DesignTokens.Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.IconSize.xxl))
                .foregroundColor(.secondary)
            
            VStack(spacing: DesignTokens.Spacing.xs) {
                Text(title)
                    .font(DesignTokens.Typography.headlineSmall)
                    .foregroundColor(.primary)
                
                Text(message)
                    .font(DesignTokens.Typography.bodyMedium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(DesignTokens.Typography.labelLarge)
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        .padding(.vertical, DesignTokens.Spacing.sm)
                        .background(Color.appPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(DesignTokens.BorderRadius.md)
                }
            }
        }
        .padding(DesignTokens.Spacing.xl)
        .frame(maxWidth: 400)
    }
}

#Preview {
    VStack(spacing: 40) {
        EmptyState(
            icon: "person.2.slash",
            title: "No People Yet",
            message: "Add people to start tracking important dates and gifts for them."
        )
        
        EmptyState(
            icon: "calendar.badge.exclamationmark",
            title: "No Events",
            message: "Create your first event to never miss an important date.",
            actionTitle: "Add Event",
            action: {}
        )
    }
}

