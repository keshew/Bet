import SwiftUI

class BetTasksViewModel: ObservableObject {
    let contact = BetTasksModel()
    @Published var tasks: [TaskModel] = []
    @Published var isAdd = false
    private let userDefaultsManager = UserDefaultsManager()
    init() {
        loadTasks()
    }
    
    func loadTasks() {
        let userDefaultsManager = UserDefaultsManager()
        tasks = userDefaultsManager.fetchTasks()
    }
    
    func deleteTask(_ task: TaskModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.userDefaultsManager.deleteTask(task)
                self.loadTasks()
            }
        }
    }
}
