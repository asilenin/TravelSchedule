import SwiftUI

struct CityRowView: View {
    let city: City
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    
    var body: some View {
        HStack {
            Text(city.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(isDarkModeEnabled ? Color.whiteUniversalTS : Color.blackUniversalTS)
            Spacer()
            
            Image(.chevronForward)
                .renderingMode(.template)
                .foregroundColor(isDarkModeEnabled ? Color.whiteUniversalTS : Color.blackUniversalTS)
        }
        .padding(.vertical, 12)
        .background(isDarkModeEnabled ? Color.blackUniversalTS : Color.whiteUniversalTS)
    }
}
