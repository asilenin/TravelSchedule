import Foundation
import Combine

final class StoriesViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var stories: [StoryModel] = []
    @Published var currentStoryIndex: Int = 0

    // MARK: - Initializers

    init() {
        loadStories()
    }

    // MARK: - Public Methods

    func loadStories() {
        stories = MockStories.stories
    }

    func markStorySeen(at index: Int) {
        guard stories.indices.contains(index) else { return }
        stories[index].isSeen = true
    }

    func openStory(at index: Int) {
        currentStoryIndex = index
    }
}
