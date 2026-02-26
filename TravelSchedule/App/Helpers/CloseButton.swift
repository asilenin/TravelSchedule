import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(.closeButton)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .contentShape(Rectangle())
        }
    }
}
