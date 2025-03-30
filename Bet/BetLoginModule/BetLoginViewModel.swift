import SwiftUI

class BetLoginViewModel: ObservableObject {
    let contact = BetLoginModel()
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var isTab = false
    @Published var isOnb = false

    func login() -> Bool {
        guard !email.isEmpty else {
            alertMessage = "Please enter email"
            showErrorAlert = true
            return false
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter password"
            showErrorAlert = true
            return false
        }
        
        let userDefaults = UserDefaultsManager()
        return userDefaults.login(email: email, password: password)
    }
}
