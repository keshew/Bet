import SwiftUI

class BetAddTaskViewModel: ObservableObject {
    let contact = BetAddTaskModel()
    @Published var title = ""
    @Published var description = ""
    @Published var name = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var time2: Date = Date()
    @Published var isLow = true
    @Published var isMed = false
    @Published var isHigh = false
    @Published var isOn = false
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var selection: String?
    
    func saveTask() -> Bool {
        guard !title.isEmpty else {
            alertMessage = "Please enter name."
            showErrorAlert = true
            return false
        }

        guard !description.isEmpty else {
            alertMessage = "Please add description"
            showErrorAlert = true
            return false
        }

        guard selection != nil else {
            alertMessage = "Please choose category"
            showErrorAlert = true
            return false
        }

        guard isLow || isMed || isHigh else {
            alertMessage = "Please select priority"
            showErrorAlert = true
            return false
        }

        let priority: Priority = isLow ? .Low :
                              isMed ? .Medium :
                              .Hight

        let task = TaskModel(
            name: title,
            date: date,
            time: time,
            desk: description,
            priority: priority,
            category: selection ?? "Unknown",
            reminder: remindBefore,
            isRepeatTask: isOn
        )

        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.saveTask(task)
        NotificationManager.shared.scheduleNotificationTask(task: task)
        return true
    }
    
    private var dateComponentsFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateFormat = "MMM d, yyyy"
           return formatter
       }
    
    var currentDate: String {
        dateComponentsFormatter.string(from: date)
    }
    
    private var timeComponentsFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var currentTime: String {
        timeComponentsFormatter.string(from: date)
    }
    
    private var remindBeforeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }

    var remindBefore: String {
        remindBeforeFormatter.string(from: time2)
    }
}
