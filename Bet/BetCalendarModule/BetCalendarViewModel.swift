import SwiftUI

class BetCalendarViewModel: ObservableObject {
    let contact = BetCalendarModel()
    @Published var currentDate = Date()
    @Published var dates: [Date] = []
    @Published var isYes = false
    @Published var isNo = false
    @Published var isAdd = false
    let grid = Array(repeating: GridItem(.flexible(), spacing: -30), count: 7)
    @Published var events: [EventModel] = []
    @Published var events2: [EventModel] = []
    
    
    init() {
        loadEvents()
        loadEvents2()
        generateDates()
    }
    
    private let calendar = Calendar.current
      
      func loadEvents2() {
          let today = Date()
          events2 = UserDefaultsManager().fetchEvents()
              .filter { calendar.isDate($0.date, equalTo: today, toGranularity: .day) }
      }
    
    func loadEvents() {
        let userDefaultsManager = UserDefaultsManager()
        events = userDefaultsManager.fetchEvents()
    }
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    var currentMonth: String {
        monthFormatter.string(from: currentDate)
    }
    
    private var todayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }
    
    var formattedToday: String {
        "Today: \(todayFormatter.string(from: Date()))"
    }
    
    private var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    var currentYear: String {
        yearFormatter.string(from: currentDate)
    }
    
    var daysOfWeek: [String] {
        contact.dayOfWeek
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date())
    }
    
    func generateDates() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let firstDayOfMonth = calendar.date(from: components) else { return }
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)!.count
        let totalDaysNeeded = 35
        var datesArray: [Date] = []
        
        for day in 1...daysInMonth {
            datesArray.append(calendar.date(from: DateComponents(
                year: components.year!,
                month: components.month!,
                day: day
            ))!)
        }
        
        let remainingDays = totalDaysNeeded - daysInMonth
        if remainingDays > 0 {
            let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
            let previousMonthDays = calendar.range(of: .day, in: .month, for: previousMonthDate)!.count
            var previousDays: [Date] = []
            for day in (previousMonthDays - remainingDays + 1)...previousMonthDays {
                let date = calendar.date(from: DateComponents(
                    year: calendar.component(.year, from: previousMonthDate),
                    month: calendar.component(.month, from: previousMonthDate),
                    day: day
                ))!
                previousDays.append(date)
            }
            
            datesArray.insert(contentsOf: previousDays, at: 0)
        }
        dates = datesArray
    }
    
    func previousMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
        generateDates()
    }
    
    func nextMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
        generateDates()
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    func isDatePassed(dateString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        guard let _ = formatter.date(from: dateString) else {
            return true
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let todayString = formatter.string(from: today)
        
        return dateString < todayString
    }
}
