import SwiftUI

struct SplashScreen: View {

    // MARK: - Private Properties

    @State private var isActive = false
    @EnvironmentObject var container: AppContainer

    // MARK: - Visual Components

    var body: some View {
        if isActive {
            TabBarView()
        } else {
            ZStack {
                Image(.splashScreen)
                    .resizable()
                    .ignoresSafeArea()
            }
            .task {
                let start = Date()

                await container.preloadStations()

                let elapsed = Date().timeIntervalSince(start)
                let remaining = max(0, 2.0 - elapsed)

                try? await Task.sleep(nanoseconds: UInt64(remaining * 1_000_000_000))

                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SplashScreen()
}
