import SwiftUI
import Combine

struct StoryHelper {

    // MARK: - Public Properties

    let timerTickInternal: TimeInterval
    let secondsPerStory: TimeInterval
    let storiesCount: Int
    let progressPerTick: CGFloat

    // MARK: - Initializers

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.05
    ) {
        self.storiesCount = storiesCount
        self.secondsPerStory = secondsPerStory
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
