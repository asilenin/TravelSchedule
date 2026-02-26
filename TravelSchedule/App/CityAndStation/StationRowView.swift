import SwiftUI

struct StationRowView: View {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    
    let station: Station
    var body: some View {
        HStack {
            Text(station.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(isDarkModeEnabled ? .whiteUniversalTS : .blackUniversalTS)
            Spacer()
            
            Image(.chevronForward)
                .renderingMode(.template)
                .foregroundColor(isDarkModeEnabled ? .whiteUniversalTS : .blackUniversalTS)
        }
        .padding(.vertical, 12)
        .background(isDarkModeEnabled ? .blackUniversalTS : .whiteUniversalTS)
    }
}

#Preview {
    List{
        StationRowView(station: Station(name: "Test Station"))
        .padding()
    }
    .background(.grayUniversalTS)
}
