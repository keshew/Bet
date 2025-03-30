import SwiftUI

class BetEditViewModel: ObservableObject {
    let contact = BetEditModel()
    @Published var name = "\(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "Name") ?? "Name")"
    
    func saveChanges() -> Bool {
        return UserDefaultsManager().updateNickname(for: UserDefaultsManager().getEmail() ?? "", newNickname: name)
    }
}
