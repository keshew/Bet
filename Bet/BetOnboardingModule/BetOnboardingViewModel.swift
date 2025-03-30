import SwiftUI

class BetOnboardingViewModel: ObservableObject {
    let contact = BetOnboardingModel()
    @Published var currentIndex = 0
    @Published var isMenu = false
}
