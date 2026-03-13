import SwiftUI

struct CloseButton: View {

    // MARK: - Public Properties

    let action: () -> Void

    // MARK: - Visual Components

    var body: some View {
        Button(
            action: {
                action()
            }
        ) {
            Image(.closeButton)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .contentShape(Rectangle())
        }
    }
}
