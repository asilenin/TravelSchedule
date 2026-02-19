import SwiftUI

struct NoInternetView: View {
    
    var body: some View {
        
        VStack{
            Image(.noInternet)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                .cornerRadius(70)
               
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
        }
    }
}

#Preview {
    NoInternetView()
}
