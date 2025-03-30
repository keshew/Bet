import SwiftUI

class BetProfileViewModel: ObservableObject {
    let contact = BetProfileModel()
    @Published var isEdit = false
    @Published var isLogOut = false
    @Published var isOn: Bool {
          didSet {
              UserDefaults.standard.set(isOn, forKey: "isOn")
          }
      }
    
    init() {
          isOn = UserDefaults.standard.bool(forKey: "isOn")
      }
}
