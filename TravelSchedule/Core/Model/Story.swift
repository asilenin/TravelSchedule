import Foundation

struct StoryModel: Identifiable, Sendable {
    let id = UUID()
    let imageName: String
    let title: String
    let text: String
    var isSeen: Bool
}
