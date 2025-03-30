import SwiftUI

class BetSignInViewModel: ObservableObject {
    let contact = BetSignInModel()
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var isLog = false
    
    func register() -> Bool {
        guard !name.isEmpty else {
            alertMessage = "Please enter name"
            showErrorAlert = true
            return false
        }
        
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
        return userDefaults.register(
            email: email,
            password: password,
            nickname: name
        )
    }

}
