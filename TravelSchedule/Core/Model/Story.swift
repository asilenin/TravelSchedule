import Foundation

struct StoryModel: Identifiable, Sendable {
    
    // MARK: - Public Properties

    let id = UUID()
    let imageName: String
    let title: String
    let text: String
    var isSeen: Bool
}
