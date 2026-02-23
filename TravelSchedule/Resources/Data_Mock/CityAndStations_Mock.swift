struct CityAndStationsMockData {
    static let cities: [City] = [
        City(name: "Москва", stations: [
            Station(name: "Киевский вокзал"),
            Station(name: "Курский вокзал"),
            Station(name: "Ярославский вокзал"),
            Station(name: "Белорусский вокзал"),
            Station(name: "Савеловский вокзал"),
            Station(name: "Ленинградский вокзал"),
            Station(name: "Рижский вокзал")
        ]),
        City(name: "Санкт-Петербург", stations: [
            Station(name: "Московский вокзал"),
            Station(name: "Ладожский вокзал"),
            Station(name: "Балтийский вокзал"),
            Station(name: "Витебский вокзал"),
            Station(name: "Финляндский вокзал")
        ]),
        City(name: "Сочи", stations: [
            Station(name: "Сочи"),
            Station(name: "Адлер"),
            Station(name: "Имеретинский курорт")
        ]),
        City(name: "Горный воздух", stations: [
            Station(name: "Горный Воздух")
        ]),
        City(name: "Краснодар", stations: [
            Station(name: "Краснодар 1"),
            Station(name: "Краснодар 2")
        ]),
        City(name: "Казань", stations: [
            Station(name: "Казань"),
            Station(name: "Казань 2")
        ]),
        City(name: "Омск", stations: [
            Station(name: "вокзал Омск-Пассажирский")
        ])
    ]
}
