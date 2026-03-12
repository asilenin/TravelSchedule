import SwiftUI
import Combine

struct CarrierSelectView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ScheduleViewModel
    var titleText: String

    init(segments: [Components.Schemas.Segment],
         titleText: String) {
        _viewModel = StateObject(wrappedValue: ScheduleViewModel(segments: segments))
        self.titleText = titleText
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            mainContent
            navigationLinkButton
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            navigationHeader
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                routeTitle
                content
            }
            .padding(.bottom, 24)
            .background(.whiteTS)
        }
        .background(.whiteTS)
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
            
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .error(let message):
            VStack(spacing: 16) {
                ErrorView(type: .serverError)
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.grayUniversalTS)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
        case .loaded(let segments):
            if segments.isEmpty {
                emptyScheduleView
            } else {
                scheduleListView(segments: segments)
            }
        }
    }
    
    
    private var navigationHeader: some View {
        NavigationView(title: "", showBackButton: true, backAction: {
            dismiss()
        })
    }
    
    private var routeTitle: some View {
        Text(titleText)
            .font(.system(size: 24, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private var emptyScheduleView: some View {
        VStack {
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blackTS)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 221)
            Spacer()
        }
    }
    
    private func scheduleListView(segments: [Components.Schemas.Segment]) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(segments.enumerated()), id: \.offset) { _, segment in
                    NavigationLink {
                        CarrierInfoView(
                            carrier: viewModel.makeCarrierInfo(from: segment)
                        )
                    } label: {
                        TravelCardView(segment: segment)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private var navigationLinkButton: some View {
        NavigationLink {
            TimeFilterView(
                viewModel: viewModel
            )
        } label: {
            SpecifyTimeButton {
            }
            .disabled(true)
        }
    }
}
