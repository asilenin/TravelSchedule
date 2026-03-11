import SwiftUI
import Combine

struct StoriesSectionView: View {

    @ObservedObject var viewModel: StoriesViewModel
    @Binding var showStories: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                    StoryPreview(
                        story: story,
                        onStoryTap: { tappedIndex in
                            viewModel.currentStoryIndex = tappedIndex
                            showStories = true
                        },
                        currentIndex: index
                    )
                    .padding(.vertical, 2)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 140)
        .padding(.vertical, 24)
    }
}
