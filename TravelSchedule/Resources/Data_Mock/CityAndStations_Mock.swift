// MARK: - Mock Service

struct MockStationsListService: StationsListServiceProtocol {
    
    func getCities() async throws -> [CityModel] {
        CityAndStationsMockData.cities
    }

    func getStations(for city: CityModel) async throws -> [StationModel] {
        city.stations
    }

    // Optional: keep if protocol still requires it somewhere
    func getStations() async throws -> [StationModel] {
        CityAndStationsMockData.cities
            .flatMap { $0.stations }
    }
}


struct CityAndStationsMockData {

    static let cities: [CityModel] = [
        CityModel(id: "moscow", name: "Москва", stations: [
            StationModel(
                id: "msk_kiev",
                yandexCode: "s1234567",
                title: "Киевский вокзал",
                settlement: "Москва",
                shortTitle: "Киевский",
                popularTitle: "Киевский вокзал",
                lat: 55.743,
                lng: 37.567,
                stationType: "train_station",
                transportType: "train"
            ),
            StationModel(
                id: "msk_kursk",
                yandexCode: "s1234567",
                title: "Курский вокзал",
                settlement: "Москва",
                shortTitle: "Курский",
                popularTitle: "Курский вокзал",
                lat: 55.757,
                lng: 37.659,
                stationType: "train_station",
                transportType: "train"
            ),
            StationModel(
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
        ]),

        CityModel(id: "saint_petersburg", name: "Санкт-Петербург", stations: [
            StationModel(
                id: "spb_moskovsky",
                yandexCode: "s1234567",
                title: "Московский вокзал",
                settlement: "Санкт-Петербург",
                shortTitle: "Московский",
                popularTitle: nil,
                lat: 59.931,
                lng: 30.362,
                stationType: "train_station",
                transportType: "train"
            ),
            StationModel(
                id: "spb_ladozhsky",
                yandexCode: "s1234567",
                title: "Ладожский вокзал",
                settlement: "Санкт-Петербург",
                shortTitle: "Ладожский",
                popularTitle: nil,
                lat: 59.931,
                lng: 30.439,
                stationType: "train_station",
                transportType: "train"
            )
        ]),

        CityModel(id: "sochi", name: "Сочи", stations: [
            StationModel(
                id: "sochi_main",
                yandexCode: "s1234567",
                title: "Сочи",
                settlement: "Сочи",
                shortTitle: nil,
                popularTitle: "ЖД Сочи",
                lat: 43.602,
                lng: 39.734,
                stationType: "train_station",
                transportType: "train"
            ),
            StationModel(
                id: "sochi_adler",
                yandexCode: "s1234567",
                title: "Адлер",
                settlement: "Сочи",
                shortTitle: nil,
                popularTitle: nil,
                lat: 43.433,
                lng: 39.923,
                stationType: "train_station",
                transportType: "train"
            )
        ])
    ]
}
