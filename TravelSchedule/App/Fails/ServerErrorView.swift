import SwiftUI

struct ServerErrorView: View {
    
    var body: some View {
        
        VStack{
            Image(.serverError)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                .cornerRadius(70)
               
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
        }
    }
}

#Preview {
    ServerErrorView()
}
