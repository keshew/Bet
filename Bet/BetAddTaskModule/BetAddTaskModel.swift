import SwiftUI

struct TaskModel: Codable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var date: Date
    var time: Date
    var desk: String
    var priority: Priority
    var category: String
    var reminder: String
    var isRepeatTask: Bool
    var isTapped: Bool = false
}

enum Priority: Codable {
    case Low
    case Medium
    case Hight
}
struct BetAddTaskModel {
 
}


