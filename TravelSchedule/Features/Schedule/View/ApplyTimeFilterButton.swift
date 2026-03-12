import SwiftUI

struct ApplyTimeFilterButton: View {

    // MARK: - Public Properties

    let action: () -> Void

    // MARK: - Visual Components

    var body: some View {
        button
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
    }

    // MARK: - Private Methods

    private var button: some View {
        Button(action: action) {
            Text("Применить")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.whiteUniversalTS)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.blueUniversalTS)
                .cornerRadius(16)
        }
    }
}

// MARK: - Preview

#Preview {
    ApplyTimeFilterButton {
        print("Кнопка нажата")
    }
}
