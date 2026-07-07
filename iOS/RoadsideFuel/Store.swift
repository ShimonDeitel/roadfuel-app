import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [FillUp] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Must stay above the seed-data count so a fresh install
    /// never hits the paywall immediately.
    static let freeLimit = 10

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("roadsidefuel_items.json")
    }()

    init() {
        load()
        if items.isEmpty {
            seed()
        }
    }

    private func seed() {
        items = [
            FillUp(title: "Shell - Route 40", value2: 12.4),
            FillUp(title: "Pilot Travel Center", value2: 14.1)
        ]
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([FillUp].self, from: data) {
            items = decoded
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    @discardableResult
    func add(_ item: FillUp) -> Bool {
        guard canAddMore else { return false }
        items.insert(item, at: 0)
        save()
        return true
    }

    func update(_ item: FillUp) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: FillUp) {
        items.removeAll(where: { $0.id == item.id })
        save()
    }
}
