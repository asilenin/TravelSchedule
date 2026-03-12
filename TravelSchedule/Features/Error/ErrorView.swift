import SwiftUI

struct ErrorView: View {
    
    let type: ErrorViewType
    
    var body: some View {
        VStack {
            Image(type.image)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                .cornerRadius(70)
            
            Text(type.title)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
        }
    }
}
