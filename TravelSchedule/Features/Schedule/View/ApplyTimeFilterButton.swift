import SwiftUI

struct ApplyTimeFilterButton: View {
    let action: () -> Void
    var body: some View {
        button
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
    }
    
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

#Preview {
    ApplyTimeFilterButton {
        print("Кнопка нажата")
    }
}
