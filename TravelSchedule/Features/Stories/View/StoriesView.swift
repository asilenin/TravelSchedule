import SwiftUI
import Combine

struct StoriesView: View {
    @ObservedObject var viewModel: StoriesViewModel
    @Binding var showFullScreenStory: Bool
    @Environment(\.dismiss) var dismiss
    @State private var progress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    private let storyHelper: StoryHelper
    private var currentStory: StoryModel { viewModel.stories[viewModel.currentStoryIndex] }
    
    init(
        viewModel: StoriesViewModel,
        showFullScreenStory: Binding<Bool>,
        startIndex: Int
    ) {
        self.viewModel = viewModel
        self._showFullScreenStory = showFullScreenStory
        
        if viewModel.currentStoryIndex != startIndex {
            viewModel.openStory(at: startIndex)
        }
        
        let helper = StoryHelper(storiesCount: max(viewModel.stories.count, 1))
        self.storyHelper = helper
        self._progress = State(initialValue: CGFloat(startIndex) / CGFloat(max(viewModel.stories.count, 1)))
        self._timer = State(initialValue: Self.createTimer(storyHelper: helper))
    }
    
    var body: some View {
        TabView() {
            ZStack(alignment: .topTrailing) {
                StoryView(story: currentStory)
                ProgressBar(numberOfSections: viewModel.stories.count, progress: progress)
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
                    nextStory()
                    //resetTimer()
                } else {
                    previousStory()
                    //resetTimer()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(Color(.blackUniversalTS).edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
    
    private func timerTick() {
        let nextProgress = progress + storyHelper.progressPerTick
        let storiesCount = viewModel.stories.count
        let currentStoryEndProgress = CGFloat(viewModel.currentStoryIndex + 1) / CGFloat(storiesCount)
        if nextProgress >= currentStoryEndProgress {
            nextStory()
            //resetTimer()
        } else {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        viewModel.markStorySeen(at: viewModel.currentStoryIndex)
        let storiesCount = viewModel.stories.count
        let nextStoryIndex = viewModel.currentStoryIndex + 1
        if nextStoryIndex < storiesCount {
            viewModel.currentStoryIndex = nextStoryIndex
            withAnimation {
                progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
            }
        }else{
            dismiss()
        }
    }
    
    private func previousStory() {
        let storiesCount = viewModel.stories.count
        let nextStoryIndex = viewModel.currentStoryIndex - 1
        if nextStoryIndex < 0 {
            viewModel.currentStoryIndex = 0
        } else {
            viewModel.currentStoryIndex = nextStoryIndex
        }
        
        withAnimation {
            let safeIndex = max(nextStoryIndex, 0)
            progress = CGFloat(safeIndex) / CGFloat(storiesCount)
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
    StoriesView(
        viewModel: StoriesViewModel(),
        showFullScreenStory: .constant(true),
        startIndex: 0
    )
}
