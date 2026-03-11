import SwiftUI

struct NavigationView: View {
    @Environment(\.dismiss) var dismiss
    
    var title: String
    var showBackButton: Bool
    var backButtonWidth: CGFloat = 42
    var backAction: (() -> Void)?
    
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
                .foregroundColor(Color.blackTS)
            Spacer()
            Spacer().frame(width: backButtonWidth)
        }
        .padding(.vertical, 10)
        .background(Color.whiteTS)
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
