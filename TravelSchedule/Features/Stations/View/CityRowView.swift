import SwiftUI

struct CityRowView: View {

    // MARK: - Public Properties

    let city: CityModel

    // MARK: - Visual Components

    var body: some View {
        HStack {
            Text(city.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.blackTS)

            Spacer()

            Image(.chevronForward)
                .renderingMode(.template)
                .foregroundColor(.blackTS)
        }
        .padding(.vertical, 12)
        .background(.whiteTS)
    }
}
