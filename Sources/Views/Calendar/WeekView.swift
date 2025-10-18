import SwiftUI

struct WeekView: View {
    @Binding var selectedDate: Date
    
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let weekStart = calendar.dateInterval(of: .weekOfMonth, for: selectedDate)?.start ?? selectedDate
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: weekStart) }
    }
    
    var body: some View {
        PlannerCard {
            VStack(spacing: DesignTokens.Spacing.medium) {
                // Week header
                HStack {
                    Button {
                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? selectedDate
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(DesignTokens.Colors.textSecondary)
                    }
                    
                    Spacer()
                    
                    Text(weekRangeText)
                        .font(DesignTokens.Typography.headline)
                        .foregroundStyle(DesignTokens.Colors.textPrimary)
                    
                    Spacer()
                    
                    Button {
                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate) ?? selectedDate
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(DesignTokens.Colors.textSecondary)
                    }
                }
                
                // Day columns
                HStack(spacing: DesignTokens.Spacing.small) {
                    ForEach(weekDays, id: \.self) { date in
                        DayColumn(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                            .onTapGesture {
                                selectedDate = date
                            }
                    }
                }
            }
        }
    }
    
    private var weekRangeText: String {
        let calendar = Calendar.current
        let weekStart = calendar.dateInterval(of: .weekOfMonth, for: selectedDate)?.start ?? selectedDate
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) ?? selectedDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        
        return "\(formatter.string(from: weekStart)) - \(formatter.string(from: weekEnd))"
    }
}

struct DayColumn: View {
    let date: Date
    let isSelected: Bool
    
    private var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        VStack(spacing: DesignTokens.Spacing.small) {
            Text(dayName)
                .font(DesignTokens.Typography.caption)
                .foregroundStyle(DesignTokens.Colors.textSecondary)
            
            ZStack {
                Circle()
                    .fill(isSelected ? DesignTokens.Colors.primary : (isToday ? DesignTokens.Colors.primary.opacity(0.1) : Color.clear))
                    .frame(width: 40, height: 40)
                
                Text(dayNumber)
                    .font(DesignTokens.Typography.body)
                    .fontWeight(isSelected || isToday ? .bold : .regular)
                    .foregroundStyle(isSelected ? .white : DesignTokens.Colors.textPrimary)
            }
            
            // Event indicators (placeholder dots)
            HStack(spacing: 2) {
                ForEach(0..<min(3, 2), id: \.self) { _ in
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                        .frame(width: 4, height: 4)
                }
            }
            .frame(height: 6)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeekView(selectedDate: .constant(Date()))
        .padding()
}

