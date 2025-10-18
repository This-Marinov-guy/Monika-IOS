import SwiftUI

public struct GiftsListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var showingGiftForm = false
    @State private var filterPurchased: FilterOption = .all
    
    public init() {}
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case purchased = "Purchased"
        case notPurchased = "To Buy"
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Adaptive gradient background
                (colorScheme == .dark 
                    ? DesignTokens.Gradients.backgroundDarkGifts
                    : DesignTokens.Gradients.backgroundLightGifts)
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Filter picker with adaptive background
                    VStack(spacing: 0) {
                        Picker("Filter", selection: $filterPurchased) {
                            ForEach(FilterOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    .background(
                        LinearGradient(
                            colors: colorScheme == .dark 
                                ? [DesignTokens.Colors.accentDark.opacity(0.3), DesignTokens.Colors.backgroundDarkSecondary]
                                : [DesignTokens.Colors.accentSubtle.opacity(0.3), DesignTokens.Colors.white],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    ScrollView {
                        VStack(spacing: DesignTokens.Spacing.medium) {
                            SearchBar(text: $searchText, placeholder: "Search gifts...")
                                .padding(.horizontal)
                            
                            // Grouped by person
                            VStack(alignment: .leading, spacing: DesignTokens.Spacing.large) {
                                GiftPersonSection(personName: "John Doe", gifts: [
                                    GiftItem(name: "Watch", price: 299.99, purchased: false, priority: "high"),
                                    GiftItem(name: "Book Collection", price: 49.99, purchased: true, priority: "medium")
                                ])
                                
                                GiftPersonSection(personName: "Jane Smith", gifts: [
                                    GiftItem(name: "Necklace", price: 159.99, purchased: false, priority: "high")
                                ])
                            }
                            .padding()
                            
                            // Empty state when no gifts
                            if false {
                                EmptyState(
                                    icon: "gift.fill",
                                    title: "No gifts yet",
                                    message: "Add gift ideas for your loved ones"
                                )
                                .padding()
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Gifts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingGiftForm = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                }
            }
            .sheet(isPresented: $showingGiftForm) {
                GiftFormSheet()
            }
        }
    }
}

struct GiftPersonSection: View {
    @Environment(\.colorScheme) var colorScheme
    let personName: String
    let gifts: [GiftItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.small) {
            Text(personName)
                .font(DesignTokens.Typography.headline)
                .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                .slideInFromLeft(delay: 0.1)
            
            ForEach(Array(gifts.enumerated()), id: \.element.id) { index, gift in
                GiftCard(gift: gift)
                    .slideInFromRight(delay: 0.2 + Double(index) * AnimationConstants.staggerDelay)
            }
        }
    }
}

struct GiftItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let purchased: Bool
    let priority: String
}

struct GiftCard: View {
    @Environment(\.colorScheme) var colorScheme
    let gift: GiftItem
    @State private var showCelebration = false
    @State private var iconScale: CGFloat = 1.0
    
    var body: some View {
        PlannerCard {
            HStack(spacing: DesignTokens.Spacing.medium) {
                // Gift icon with animation
                ZStack {
                    Circle()
                        .fill(gift.purchased ? Color.green.opacity(0.1) : DesignTokens.Colors.primary.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: gift.purchased ? "checkmark.circle.fill" : "gift.fill")
                        .foregroundStyle(gift.purchased ? .green : DesignTokens.Colors.primary)
                        .scaleEffect(iconScale)
                }
                
                // Gift details
                VStack(alignment: .leading, spacing: 4) {
                    Text(gift.name)
                        .font(DesignTokens.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                        .strikethrough(gift.purchased)
                    
                    HStack(spacing: DesignTokens.Spacing.small) {
                        Text("$\(String(format: "%.2f", gift.price))")
                            .font(DesignTokens.Typography.subheadline)
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                        
                        PriorityBadge(priority: gift.priority)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(DesignTokens.Colors.adaptiveTextTertiary(colorScheme))
            }
        }
        .celebrate(trigger: showCelebration)
        .onAppear {
            if gift.purchased {
                // Bounce animation for purchased items
                withAnimation(AnimationConstants.bouncy) {
                    iconScale = 1.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(AnimationConstants.bouncy) {
                        iconScale = 1.0
                    }
                }
            }
        }
    }
}

struct PriorityBadge: View {
    let priority: String
    
    private var color: Color {
        switch priority.lowercased() {
        case "high": return .red
        case "medium": return .orange
        case "low": return .blue
        default: return .gray
        }
    }
    
    var body: some View {
        Text(priority.capitalized)
            .font(DesignTokens.Typography.caption)
            .fontWeight(.medium)
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(color.opacity(0.1))
            .cornerRadius(4)
    }
}

#Preview {
    GiftsListView()
}

