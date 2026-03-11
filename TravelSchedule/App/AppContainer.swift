import Foundation
import Combine
import OpenAPIRuntime
import OpenAPIURLSession

@MainActor
final class AppContainer: ObservableObject {

    let stationsListService: StationsListServiceProtocol

    private let networkClient: NetworkClient

    init() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        let apiKey = try APIConfiguration.yandexRaspAPIKey()

        let network = NetworkClient(client: client, apikey: apiKey, stationsListBodyLimit: ServiceConstants.StationsListServiceGetAllStationsTimeLimit)
        self.networkClient = network

        self.stationsListService = StationsListService(network: network)
    }
    
    func makeNetworkClient() -> NetworkClient {
        networkClient
    }
    
    func makeStationsListService() -> StationsListService {
        StationsListService(network: networkClient)
    }
    
    func makeScheduleService() -> ScheduleService {
        ScheduleService(network: networkClient)
    }
    
    func makeSearchService() -> SearchService {
        SearchService(network: networkClient)
    }
    
    func makeCitiesListViewModel() -> CitiesListViewModel {
        CitiesListViewModel(service: makeStationsListService())
    }
    
    func preloadStations() async {
        do {
            _ = try await stationsListService.getCities()
        } catch {
            print("Preload failed:", error)
        }
    }
}
