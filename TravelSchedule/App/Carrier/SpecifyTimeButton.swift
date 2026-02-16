import SwiftUI

struct SpecifyTimeButton: View {
    
    let action: () -> Void
    
    var body: some View {
        button
            .padding(.horizontal)
            .padding(.bottom, 24)
    }
    
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

#Preview {
    SpecifyTimeButton {
    }
}
