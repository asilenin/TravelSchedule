import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testServices()
        }
    }
}

#Preview {
    ContentView()
}

func testServices(){
    testFetchStations()
    testFetchSearch()
    testFetchSchedule()
    testFetchThread()
    testFetchGeography()
    testFetchCarrier()
    testFetchStationsList()
    testFetchCopyright()
}
