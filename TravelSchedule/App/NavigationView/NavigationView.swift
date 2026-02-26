import SwiftUI

struct NavigationView: View {
    var title: String
    var showBackButton: Bool
    var backButtonWidth: CGFloat = 42
    var backAction: (() -> Void)?
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            if showBackButton {
                ChevronBackButton {
                    if let backAction {
                        backAction()
                    } else {
                        dismiss()
                    }
                }
                .frame(width: backButtonWidth, alignment: .leading)
            } else {
                Spacer().frame(width: backButtonWidth)
            }
            Spacer()
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(isDarkModeEnabled ? Color.whiteUniversalTS : Color.blackUniversalTS)
            Spacer()
            Spacer().frame(width: backButtonWidth)
        }
        .padding(.vertical, 10)
        .background(isDarkModeEnabled ? Color.blackUniversalTS : Color.whiteUniversalTS)
        .padding(.vertical, 11)
    }
}

#Preview {
    NavigationView(
        title: "",
        showBackButton: true,
        backAction: {
        }
    )
    .padding()
    .background(.grayUniversalTS)
}
