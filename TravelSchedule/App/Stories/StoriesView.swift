import SwiftUI
import Combine

struct StoriesView: View {
    let stories: [StoryModel]
    @Binding var showFullScreenStory: Bool
    @Environment(\.dismiss) var dismiss
    let onStoryMarkedSeen: (Int) -> Void
    
    @Binding var currentStoryIndex: Int
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    private let storyHelper: StoryHelper
    private var currentStory: StoryModel { stories[currentStoryIndex] }
    
    init(
        stories: [StoryModel],
        currentStoryIndex: Binding<Int>,
        showFullScreenStory: Binding<Bool>,
        onStoryMarkedSeen: @escaping (Int) -> Void,
        storyHelper: StoryHelper
    ) {
        self.stories = stories
        self._currentStoryIndex = currentStoryIndex
        self._showFullScreenStory = showFullScreenStory
        self.onStoryMarkedSeen = onStoryMarkedSeen
        self.storyHelper = storyHelper
        self._timer = State(initialValue: Self.createTimer(storyHelper: storyHelper))
    }
    
    var body: some View {
        TabView() {
            ZStack(alignment: .topTrailing) {
                StoryView(story: currentStory)
                ProgressBar(numberOfSections: stories.count, progress: progress)
                    .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                CloseButton(action: {dismiss()})
                    .padding(.top, 57)
                    .padding(.trailing, 12)
            }
            .onAppear {
                timer = Self.createTimer(storyHelper: storyHelper)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
            .onTapGesture { value in
                let screenWidth = UIScreen.main.bounds.width
                if value.x > screenWidth / 2 {
                    print("Tap next story")
                    nextStory()
                    resetTimer()
                } else {
                    print("Tap previous story")
                    previousStory()
                    resetTimer()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(Color(.blackUniversalTS).edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
    
    private func timerTick() {
        var nextProgress = progress + storyHelper.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        //withAnimation {
            progress = nextProgress
        //}
    }

    private func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func previousStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        
        
        let previousStoryIndex = currentStoryIndex - 1 < 1 ? 1 : currentStoryIndex - 1
        
        withAnimation {
            progress = CGFloat(previousStoryIndex) / CGFloat(storiesCount)
        }
    }

    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(storyHelper: storyHelper)
        cancellable = timer.connect()
    }

    private static func createTimer(storyHelper: StoryHelper) -> Timer.TimerPublisher {
        Timer.publish(every: storyHelper.timerTickInternal, on: .main, in: .common)
    }
}


#Preview {
    let stories = MockStories.stories
    StoriesView(
        stories: MockStories.stories,
        currentStoryIndex: .constant(0),
        showFullScreenStory: .constant(true),
        onStoryMarkedSeen: { _ in },
        storyHelper: StoryHelper(storiesCount: MockStories.stories.count)
    )
}
