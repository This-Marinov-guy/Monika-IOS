import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var fullWidth: Bool = true
    
    init(
        _ title: String,
        icon: String? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        fullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.fullWidth = fullWidth
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: DesignTokens.IconSize.sm, weight: .semibold))
                    }
                    Text(title)
                        .font(DesignTokens.Typography.labelLarge)
                }
            }
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .background(isDisabled ? Color.gray : Color.appPrimary)
            .foregroundColor(.white)
            .cornerRadius(DesignTokens.BorderRadius.md)
        }
        .disabled(isDisabled || isLoading)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton("Save", icon: "checkmark") { }
        PrimaryButton("Loading", isLoading: true) { }
        PrimaryButton("Disabled", isDisabled: true) { }
        PrimaryButton("Not Full Width", fullWidth: false) { }
    }
    .padding()
}

