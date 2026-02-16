import SwiftUI

struct CityRowView: View {
    let city: City
    
    var body: some View {
        HStack {
            Text(city.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.blackTS)
            Spacer()
            
            Image("ChevronForward")
                .renderingMode(.template)
                .foregroundColor(.blackTS)
        }
        .padding(.vertical, 12)
        .background(.whiteTS)
    }
}
