import SwiftUI

public struct PeopleListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = PeopleViewModel()
    @State private var searchText = ""
    @State private var showingPersonForm = false
    
    public init() {}
    
    private var filteredPeople: [Person] {
        viewModel.searchPeople(query: searchText)
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Adaptive gradient background
                (colorScheme == .dark 
                    ? DesignTokens.Gradients.backgroundDarkPeople
                    : DesignTokens.Gradients.backgroundLightPeople)
                .ignoresSafeArea()
                
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
                            ForEach(Array(filteredPeople.enumerated()), id: \.element.id) { index, person in
                                PersonCard(person: person)
                                    .scaleOnAppear(delay: Double(index) * AnimationConstants.staggerDelay)
                            }
                        }
                        .padding(.horizontal)
                    }
                    }
                    .padding(.vertical)
                }
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
    @Environment(\.colorScheme) var colorScheme
    let person: Person
    @State private var isPulsing = false
    
    private var birthdayText: String? {
        guard let birthday = person.birthday else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return "Birthday: \(formatter.string(from: birthday))"
    }
    
    var body: some View {
        PlannerCard {
            VStack(spacing: DesignTokens.Spacing.medium) {
                // Avatar with pulse animation
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                DesignTokens.Colors.primary.opacity(0.15),
                                DesignTokens.Colors.primary.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text(String(person.name.prefix(1)))
                            .font(DesignTokens.Typography.title)
                            .fontWeight(.bold)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                    .scaleEffect(isPulsing ? 1.05 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                        value: isPulsing
                    )
                    .onAppear {
                        isPulsing = true
                    }
                
                VStack(spacing: 4) {
                    Text(person.name)
                        .font(DesignTokens.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                        .lineLimit(1)
                    
                    if let birthdayText = birthdayText {
                        Text(birthdayText)
                            .font(DesignTokens.Typography.caption)
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
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

