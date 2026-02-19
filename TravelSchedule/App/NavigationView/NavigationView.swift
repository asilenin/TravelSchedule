import SwiftUI

struct NavigationView: View {
    var title: String
    var showBackButton: Bool
    var backButtonWidth: CGFloat = 42
    var backAction: (() -> Void)?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            if showBackButton {
                Button {
                    backAction?() ?? dismiss()
                } label: {
                    Image(.chevronBack)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 22)
                        .foregroundColor(.blackTS)
                        .padding(.leading, 8)
                }
                .frame(width: backButtonWidth, alignment: .leading)
            } else {
                Spacer().frame(width: backButtonWidth)
            }
            Spacer()
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.blackTS)
            Spacer()
            Spacer().frame(width: backButtonWidth)
        }
        .padding(.vertical, 10)
        .background(.whiteTS)
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
