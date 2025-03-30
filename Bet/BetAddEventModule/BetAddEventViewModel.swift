import SwiftUI

struct EventModel: Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var date: Date
    var time: Date
    var desc: String
    var location: String
    var remindBefore: String
    var color: String
}

class BetAddEventViewModel: ObservableObject {
    let contact = BetAddEventModel()
    @Published var title = ""
    @Published var description = ""
    @Published var name = ""
    @Published var location = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var time2: Date = Date()
    @Published var isColo1 = false
    @Published var isColo2 = false
    @Published var isColo3 = false
    @Published var isColo4 = false
    @Published var showErrorAlert = false
     @Published var alertMessage = ""

    func saveEvent() -> Bool {
        guard !title.isEmpty else {
            alertMessage = "Please enter name"
            showErrorAlert = true
            return false
        }

        guard !description.isEmpty else {
            alertMessage = "Please add description"
            showErrorAlert = true
            return false
        }

        guard isColo1 || isColo2 || isColo3 || isColo4 else {
            alertMessage = "Please choose the color"
            showErrorAlert = true
            return false
        }

        let selectedColor: String = isColo1 ? "1" :
                                    isColo2 ? "2" :
                                    isColo3 ? "3" :
                                    "4"

        let event = EventModel(
            title: title,
            date: date,
            time: time,
            desc: description,
            location: location,
            remindBefore: remindBefore,
            color: selectedColor
        )

        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.saveEvent(event)
        NotificationManager.shared.scheduleNotificationEvent(event: event)
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
