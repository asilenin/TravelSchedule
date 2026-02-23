import Foundation

struct StoryModel: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let text: String
    var isSeen: Bool
}
