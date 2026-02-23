import SwiftUI

struct ChevronForwardButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(.chevronForward)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 17, height: 22)
                .foregroundColor(.blackTS)
                .padding(.leading, 8)
        }
    }
}

