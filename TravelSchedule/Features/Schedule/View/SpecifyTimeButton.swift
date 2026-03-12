import SwiftUI

struct SpecifyTimeButton: View {

    // MARK: - Public Properties

    let action: () -> Void

    // MARK: - Visual Components

    var body: some View {
        button
            .padding(.horizontal)
            .padding(.bottom, 24)
    }

    // MARK: - Private Methods

    private var button: some View {
        Button(action: action) {
            Text("Уточнить время")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.whiteUniversalTS)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.blueUniversalTS)
                .cornerRadius(16)
        }
    }
}

// MARK: - Preview

#Preview {
    SpecifyTimeButton {}
}
