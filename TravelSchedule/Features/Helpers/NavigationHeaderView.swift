import SwiftUI

struct NavigationHeaderView: View {

    // MARK: - Public Properties

    var title: String
    var showBackButton: Bool
    var backButtonWidth: CGFloat = 42
    var backAction: (() -> Void)?

    // MARK: - Private Properties

    @Environment(\.dismiss) private var dismiss

    // MARK: - Visual Components

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
                Spacer()
                    .frame(width: backButtonWidth)
            }

            Spacer()

            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.blackTS)

            Spacer()

            Spacer()
                .frame(width: backButtonWidth)
        }
        .padding(.vertical, 10)
        .background(Color.whiteTS)
        .padding(.vertical, 11)
    }
}

// MARK: - Preview

#Preview {
    NavigationHeaderView(
        title: "",
        showBackButton: true,
        backAction: {}
    )
    .padding()
    .background(.grayUniversalTS)
}
