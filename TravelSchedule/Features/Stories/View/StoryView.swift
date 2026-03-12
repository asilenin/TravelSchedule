import SwiftUI

struct StoryView: View {

    // MARK: - Public Properties

    let story: StoryModel

    // MARK: - Visual Components

    var body: some View {
        storyImage(for: story)
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()

                    textContent
                }
            )
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(story.title)
                .font(.system(size: 34, weight: .bold))
                .kerning(0.4)
                .foregroundColor(.whiteUniversalTS)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 16)

            Text(story.text)
                .font(.system(size: 20))
                .kerning(0.4)
                .foregroundColor(.whiteUniversalTS)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 40)
        }
        .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
    }

    // MARK: - Private Methods

    private func storyImage(for story: StoryModel) -> some View {
        Image(story.imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(40)
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview

#Preview {
    let stories = MockStories.stories
    StoryView(story: stories[0])
}
