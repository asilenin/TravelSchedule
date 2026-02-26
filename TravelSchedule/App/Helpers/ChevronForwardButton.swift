import SwiftUI

struct ChevronForwardButton: View {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
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
                .foregroundColor(isDarkModeEnabled ? .whiteUniversalTS : .blackUniversalTS)
                .padding(.leading, 8)
        }
    }
}
