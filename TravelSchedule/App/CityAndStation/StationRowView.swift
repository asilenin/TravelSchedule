import SwiftUI

struct StationRowView: View {
    let station: Station
    
    var body: some View {
        HStack {
            Text(station.name)
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

#Preview {
    List{
        StationRowView(station: Station(name: "Test Station"))
        .padding()
    }
    .background(.grayUniversalTS)
}

