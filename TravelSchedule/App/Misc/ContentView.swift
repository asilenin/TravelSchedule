import SwiftUI

struct ContentView: View {
    @State private var didRun = false
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
}

#Preview {
    ContentView()
}

func testServices() async {
    
    do {
        let container = try AppContainer()
        let network = container.makeNetworkClient()
        
        await testFetchStationsList(network: network)
        await testFetchSchedule(container: container)
        await testFetchSearch(container: container)
    } catch {
        print("Failed to initialize services: \(error)")
    }
}
