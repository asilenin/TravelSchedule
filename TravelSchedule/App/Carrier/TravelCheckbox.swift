import SwiftUI

struct TravelCheckboxView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.blackTS)
                Spacer()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.title2)
                    .foregroundColor(.blackTS)
            }
            .contentShape(Rectangle())
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
