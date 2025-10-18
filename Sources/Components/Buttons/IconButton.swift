import SwiftUI

struct IconButton: View {
    let icon: String
    let action: () -> Void
    var size: CGFloat = DesignTokens.IconSize.lg
    var backgroundColor: Color = Color.adaptiveSecondaryBackground
    var foregroundColor: Color = .primary
    var cornerRadius: CGFloat = DesignTokens.BorderRadius.md
    
    init(
        icon: String,
        size: CGFloat = DesignTokens.IconSize.lg,
        backgroundColor: Color = Color.adaptiveSecondaryBackground,
        foregroundColor: Color = .primary,
        cornerRadius: CGFloat = DesignTokens.BorderRadius.md,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.6, weight: .medium))
                .foregroundColor(foregroundColor)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 16) {
        IconButton(icon: "plus") { }
        IconButton(icon: "heart.fill", backgroundColor: .appPrimary, foregroundColor: .white) { }
        IconButton(icon: "trash", size: 32, backgroundColor: .red.opacity(0.1), foregroundColor: .red) { }
    }
    .padding()
}

