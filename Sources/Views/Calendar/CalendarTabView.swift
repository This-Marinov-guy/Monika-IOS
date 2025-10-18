import SwiftUI

public struct CalendarTabView: View {
    @State private var selectedDate = Date()
    @State private var viewMode: CalendarViewMode = .month
    @State private var showingEventForm = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                DesignTokens.Colors.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // View mode picker with gradient background
                    VStack(spacing: 0) {
                        Picker("View Mode", selection: $viewMode) {
                            Text("Week").tag(CalendarViewMode.week)
                            Text("Month").tag(CalendarViewMode.month)
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    .background(
                        LinearGradient(
                            colors: [DesignTokens.Colors.primarySubtle.opacity(0.3), DesignTokens.Colors.white],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    // Calendar content
                    ScrollView {
                        VStack(spacing: DesignTokens.Spacing.large) {
                            if viewMode == .week {
                                WeekView(selectedDate: $selectedDate)
                            } else {
                                MonthView(selectedDate: $selectedDate)
                            }
                            
                            // Upcoming events section
                            UpcomingEventsSection()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingEventForm = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(DesignTokens.Colors.primary)
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button {
                        selectedDate = Date()
                    } label: {
                        Text("Today")
                            .fontWeight(.medium)
                    }
                }
            }
            .sheet(isPresented: $showingEventForm) {
                EventFormSheet()
            }
        }
    }
}

enum CalendarViewMode {
    case week
    case month
}

#Preview {
    CalendarTabView()
        .environmentObject(ThemeManager())
}

