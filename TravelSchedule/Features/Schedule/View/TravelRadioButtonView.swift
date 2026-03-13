import SwiftUI

struct TravelRadioButtonView: View {

    // MARK: - Public Properties

    let title: String
    let isSelected: Bool
    let action: () -> Void

    // MARK: - Visual Components

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: isSelected ? "record.circle" : "circle")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .contentShape(Rectangle())
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
