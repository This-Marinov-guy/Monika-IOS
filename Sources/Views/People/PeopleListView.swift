import SwiftUI

public struct PeopleListView: View {
    @StateObject private var viewModel = PeopleViewModel()
    @State private var searchText = ""
    @State private var showingPersonForm = false
    
    public init() {}
    
    private var filteredPeople: [Person] {
        viewModel.searchPeople(query: searchText)
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DesignTokens.Spacing.medium) {
                    SearchBar(text: $searchText, placeholder: "Search people...")
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if filteredPeople.isEmpty {
                        EmptyState(
                            icon: "person.2.fill",
                            title: searchText.isEmpty ? "No people yet" : "No results",
                            message: searchText.isEmpty ? "Add people to track their special days" : "Try a different search"
                        )
                        .padding()
                    } else {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: DesignTokens.Spacing.medium) {
                            ForEach(filteredPeople) { person in
                                PersonCard(person: person)
                            }
                        }
                        .padding(.horizontal)
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
                PersonFormSheet(viewModel: viewModel)
            }
            .task {
                await viewModel.fetchPeople()
            }
        }
    }
}

struct PersonCard: View {
    let person: Person
    
    private var birthdayText: String? {
        guard let birthday = person.birthday else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return "Birthday: \(formatter.string(from: birthday))"
    }
    
    var body: some View {
        PlannerCard {
            VStack(spacing: DesignTokens.Spacing.medium) {
                // Avatar
                Circle()
                    .fill(DesignTokens.Colors.primary.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text(String(person.name.prefix(1)))
                            .font(DesignTokens.Typography.title)
                            .fontWeight(.bold)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                
                VStack(spacing: 4) {
                    Text(person.name)
                        .font(DesignTokens.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignTokens.Colors.textPrimary)
                        .lineLimit(1)
                    
                    if let birthdayText = birthdayText {
                        Text(birthdayText)
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

