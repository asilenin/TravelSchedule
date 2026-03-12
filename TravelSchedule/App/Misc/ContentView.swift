import SwiftUI

struct ContentView: View {

    // MARK: - Visual Components

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Hello, world!")
        }
        .padding()
        .task {
            if !didRun {
                didRun = true
                await testServices()
            }
        }
    }

    // MARK: - Private Properties

    @State private var didRun = false
}

// MARK: - Private Methods

func testServices() async {
    do {
        let container = try AppContainer()
        let network = container.makeNetworkClient()

        await testFetchStationsList(network: network)
        await testFetchSchedule(container: container)
        await testFetchSearch(container: container)
    } catch {
        print("[ContentView]:\(#line)] \(#function) Failed to initialize services: \(error)")
    }
}

#Preview {
    ContentView()
}
