import SwiftUI

public struct PeopleListView: View {
    @State private var searchText = ""
    @State private var showingPersonForm = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DesignTokens.Spacing.medium) {
                    SearchBar(text: $searchText, placeholder: "Search people...")
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: DesignTokens.Spacing.medium) {
                        // Placeholder people
                        ForEach(0..<6, id: \.self) { index in
                            PersonCard(
                                name: "Person \(index + 1)",
                                birthday: Date(),
                                upcomingEvent: "Birthday in 10 days"
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Empty state when no people
                    if false {
                        EmptyState(
                            icon: "person.2.fill",
                            title: "No people yet",
                            message: "Add people to track their special days"
                        )
                        .padding()
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingPersonForm = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                }
            }
            .sheet(isPresented: $showingPersonForm) {
                PersonFormSheet()
            }
        }
    }
}

struct PersonCard: View {
    let name: String
    let birthday: Date?
    let upcomingEvent: String?
    
    var body: some View {
        PlannerCard {
            VStack(spacing: DesignTokens.Spacing.medium) {
                // Avatar
                Circle()
                    .fill(DesignTokens.Colors.primary.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text(String(name.prefix(1)))
                            .font(DesignTokens.Typography.title)
                            .fontWeight(.bold)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                
                VStack(spacing: 4) {
                    Text(name)
                        .font(DesignTokens.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignTokens.Colors.textPrimary)
                        .lineLimit(1)
                    
                    if let upcomingEvent = upcomingEvent {
                        Text(upcomingEvent)
                            .font(DesignTokens.Typography.caption)
                            .foregroundStyle(DesignTokens.Colors.textSecondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    PeopleListView()
}

