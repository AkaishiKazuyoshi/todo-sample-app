import SwiftUI

@main
struct birdman_todoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ListViewModel())
        }
    }
}
