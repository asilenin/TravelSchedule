import SwiftUI

struct CarrierSelectView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var path = NavigationPath()
    
    let scheduleList = MockCarriers.schedule
    var titleText: String  = CarrierSelect.titleText
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                mainContent
                navigationLinkButton
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK: - Views
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            navigationHeader
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                routeTitle
                if scheduleList.isEmpty {
                    emptyScheduleView
                } else {
                    scheduleListView
                }
            }
            .padding(.bottom, 24)
            .background(.whiteTS)
        }
        .background(.whiteTS)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var navigationHeader: some View {
        
        NavigationView(title: "", showBackButton: true, backAction: {
            dismiss()
        })
    }
    
    private var routeTitle: some View {
        Text(titleText)
            .font(.system(size: 24, weight: .bold))
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private var emptyScheduleView: some View {
        VStack {
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.whiteTS)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 221)
            Spacer()
        }
    }
    
    private var scheduleListView: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(scheduleList) { schedule in
                    TravelCardView(schedule: schedule)
                }
            }
        }
    }
    
    private var navigationLinkButton: some View {
        NavigationLink {
            TimeFilterView()
        } label: {
            SpecifyTimeButton {
                path.append("GoToTimeFilterView")
            }
            .navigationDestination(for: String.self) { route in
                if route == "GoToTimeFilterView" {
                    TimeFilterView()
                }
            }
        }
    }
}

// MARK: - ScheduleView_Preview

#Preview{
    CarrierSelectView()
}
