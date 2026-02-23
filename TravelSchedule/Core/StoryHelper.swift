import SwiftUI
import Combine

struct StoryHelper {
    let timerTickInternal: TimeInterval
    let secondsPerStory: TimeInterval
    let storiesCount: Int
    let progressPerTick: CGFloat
    
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
