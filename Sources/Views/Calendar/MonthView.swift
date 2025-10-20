import SwiftUI

struct MonthView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedDate: Date
    
    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    private var daysInMonth: [Date?] {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: selectedDate)!
        let firstWeekday = calendar.component(.weekday, from: interval.start)
        let daysCount = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        days += (0..<daysCount).compactMap { calendar.date(byAdding: .day, value: $0, to: interval.start) }
        
        return days
    }
    
    var body: some View {
        PlannerCard {
            VStack(spacing: DesignTokens.Spacing.medium) {
                // Month header
                HStack {
                    Button {
                        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                    }
                    
                    Spacer()
                    
                    Text(monthName)
                        .font(DesignTokens.Typography.headline)
                        .foregroundStyle(DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
                    
                    Spacer()
                    
                    Button {
                        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                    }
                }
                
                // Weekday headers
                HStack(spacing: 0) {
                    ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                        Text(day)
                            .font(DesignTokens.Typography.caption)
                            .foregroundStyle(DesignTokens.Colors.adaptiveTextSecondary(colorScheme))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // Calendar grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: DesignTokens.Spacing.small) {
                    ForEach(0..<daysInMonth.count, id: \.self) { index in
                        if let date = daysInMonth[index] {
                            DateCell(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                                .onTapGesture {
                                    selectedDate = date
                                }
                        } else {
                            Color.clear
                                .frame(height: 44)
                        }
                    }
                }
            }
        }
            .panelBackgroundGreenWithBorder(colorScheme)
        .cornerRadius(DesignTokens.BorderRadius.card)
    }
}

struct DateCell: View {
    @Environment(\.colorScheme) var colorScheme
    let date: Date
    let isSelected: Bool
    
    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                } else if isToday {
                    Circle()
                        .stroke(DesignTokens.Colors.primary, lineWidth: 2)
                }
                
                Text(dayNumber)
                    .font(DesignTokens.Typography.body)
                    .fontWeight(isSelected || isToday ? .bold : .regular)
                    .foregroundStyle(isSelected ? .white : DesignTokens.Colors.adaptiveTextPrimary(colorScheme))
            }
            .frame(width: 32, height: 32)
            
            // Event indicators
            HStack(spacing: 2) {
                ForEach(0..<min(3, 1), id: \.self) { _ in
                    Circle()
                        .fill(DesignTokens.Colors.primary)
                        .frame(width: 3, height: 3)
                }
            }
            .frame(height: 4)
        }
        .frame(height: 44)
    }
}

#Preview {
    MonthView(selectedDate: .constant(Date()))
        .padding()
}

