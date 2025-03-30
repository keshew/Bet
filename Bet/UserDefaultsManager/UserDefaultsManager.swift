import Foundation
import SwiftUI

class UserDefaultsManager: ObservableObject {
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")

        if !isFirstLaunch {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }

        return false
    }
    
    func deleteTask(_ task: TaskModel) {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "tasks"),
           var decodedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) {
            decodedTasks.removeAll(where: { $0.id == task.id })
            if let encodedData = try? JSONEncoder().encode(decodedTasks) {
                defaults.set(encodedData, forKey: "tasks")
            }
        }
    }
    
    func saveTask(_ task: TaskModel) {
         let defaults = UserDefaults.standard

         var tasks: [TaskModel] = []
         if let data = defaults.data(forKey: "tasks"),
            let decodedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) {
             tasks = decodedTasks
         }

         tasks.append(task)

         if let encodedData = try? JSONEncoder().encode(tasks) {
             defaults.set(encodedData, forKey: "tasks")
         }
     }

     func fetchTasks() -> [TaskModel] {
         let defaults = UserDefaults.standard

         if let data = defaults.data(forKey: "tasks"),
            let decodedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) {
             return decodedTasks
         }

         return []
     }
    
    func saveEvent(_ event: EventModel) {
           let defaults = UserDefaults.standard

           var events: [EventModel] = []
           if let data = defaults.data(forKey: "events"),
              let decodedEvents = try? JSONDecoder().decode([EventModel].self, from: data) {
               events = decodedEvents
           }

           events.append(event)

           if let encodedData = try? JSONEncoder().encode(events) {
               defaults.set(encodedData, forKey: "events")
           }
       }

       func fetchEvents() -> [EventModel] {
           let defaults = UserDefaults.standard

           if let data = defaults.data(forKey: "events"),
              let decodedEvents = try? JSONDecoder().decode([EventModel].self, from: data) {
               return decodedEvents
           }

           return []
       }
    
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func register(email: String, password: String, nickname: String) -> Bool {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: String]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: String]] {
            storedUsers = existingUsers
        }
        
        storedUsers[email] = ["password": password, "nickname": nickname]
        userDefaults.set(storedUsers, forKey: "users")
        
        saveLoginStatus(true)
        return true
    }
    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    private func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func deleteAccount() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "users")
        saveLoginStatus(false)
    }
    
    func getNickname(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            return storedUsers[email]?["nickname"]
        }
        return nil
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }
    
    func logout() {
        saveLoginStatus(false)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func updateNickname(for email: String, newNickname: String) -> Bool {
        let defaults = UserDefaults.standard
        guard var storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] else {
            return false
        }
        
        if var user = storedUsers[email] {
            user["nickname"] = newNickname
            storedUsers[email] = user
            defaults.set(storedUsers, forKey: "users")
            return true
        }
        
        return false
    }
    
    func login(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            for (storedUsername, storedUser) in storedUsers {
                if email == storedUsername && password == storedUser["password"] {
                    saveLoginStatus(true)
                    saveCurrentEmail(email)
                    return true
                }
            }
        }
        return false
    }
}
