import SwiftUI

struct ProgressBar: View {
    
    // MARK: - Public Properties
    
    let numberOfSections: Int
    let progress: CGFloat

    // MARK: - Visual Components
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Layout.progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: Layout.progressBarHeight)
                    .foregroundColor(.whiteUniversalTS)

                RoundedRectangle(cornerRadius: Layout.progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: Layout.progressBarHeight
                    )
                    .foregroundColor(.blueUniversalTS)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    
    // MARK: - Public Properties
    
    let numberOfSections: Int

    // MARK: - Visual Components
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    
    // MARK: - Visual Components
    
    var body: some View {
        RoundedRectangle(cornerRadius: Layout.progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: Layout.progressBarHeight)
            .foregroundStyle(.white)
    }
}
