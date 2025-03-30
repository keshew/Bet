import SwiftUI

@main
struct BetApp: App {
    @StateObject var notificationManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                BetTabBarView()
            } else {
                BetSignInView()
                    .onAppear {
                        notificationManager.requestPermission { granted in
                        }
                    }
            }
        }
    }
}
