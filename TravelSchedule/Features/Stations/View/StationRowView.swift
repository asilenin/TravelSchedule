import SwiftUI

struct StationRowView: View {

    // MARK: - Public Properties

    let station: StationModel

    // MARK: - Visual Components

    var body: some View {
        HStack {
            Text(station.title)
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

// MARK: - Preview

#Preview {
    List {
        StationRowView(
            station: StationModel(
                id: "msk_yaroslavl",
                yandexCode: "s1234567",
                title: "Ярославский вокзал",
                settlement: "Москва",
                shortTitle: "Ярославский",
                popularTitle: nil,
                lat: 55.776,
                lng: 37.655,
                stationType: "train_station",
                transportType: "train"
            )
        )
        .padding()
    }
    .background(.grayUniversalTS)
}
