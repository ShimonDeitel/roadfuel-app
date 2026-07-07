import SwiftUI

/// Unique visual identity for Roadside Fuel.
enum Theme {
    static let accent = Color(red: 0.847, green: 0.353, blue: 0.102)
    static let background = Color(red: 0.110, green: 0.067, blue: 0.031)
    static let cardBackground = Color(red: 0.170, green: 0.127, blue: 0.091)
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.65)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
