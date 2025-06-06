import SwiftUI

@main
struct Red_Mile_Grand_GameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RMGRoot()
                .preferredColorScheme(.light)
        }
    }
}
