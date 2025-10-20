import SwiftUI

public struct CalendarTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedDate = Date()
    @State private var viewMode: CalendarViewMode = .month
    @State private var showingEventForm = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Adaptive background gradient
                (colorScheme == .dark 
                    ? DesignTokens.Gradients.backgroundDarkCalendar
                    : DesignTokens.Gradients.backgroundLightCalendar)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                // View mode picker with adaptive gradient background
                VStack(spacing: 0) {
                    Picker("View Mode", selection: $viewMode.animation(AnimationConstants.spring)) {
                        Text("Week").tag(CalendarViewMode.week)
                        Text("Month").tag(CalendarViewMode.month)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                    .background(
                        LinearGradient(
                            colors: colorScheme == .dark 
                                ? [DesignTokens.Colors.primaryDark.opacity(0.3), DesignTokens.Colors.backgroundDarkSecondary]
                                : [DesignTokens.Colors.primarySubtle.opacity(0.3), DesignTokens.Colors.white],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    // Calendar content
                    ScrollView {
                        VStack(spacing: DesignTokens.Spacing.large) {
                            if viewMode == .week {
                                WeekView(selectedDate: $selectedDate)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .leading).combined(with: .opacity),
                                        removal: .move(edge: .trailing).combined(with: .opacity)
                                    ))
                            } else {
                                MonthView(selectedDate: $selectedDate)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)
                                    ))
                            }
                            
                            // Upcoming events section
                            UpcomingEventsSection()
                                .slideInFromBottom(delay: 0.2)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(MonikaStrings.Calendar.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingEventForm = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(DesignTokens.Colors.green)
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button {
                        selectedDate = Date()
                    } label: {
                        Text("Today")
                            .fontWeight(.medium)
                            .foregroundStyle(DesignTokens.Colors.green)
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

