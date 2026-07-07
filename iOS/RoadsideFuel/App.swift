import SwiftUI

@main
struct RoadsideFuelApp: App {
    @StateObject private var store = Store()
    @StateObject private var purchases = PurchaseManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(purchases)
                .task {
                    await purchases.refreshPurchasedState()
                    store.isPro = purchases.isPurchased
                }
        }
    }
}
