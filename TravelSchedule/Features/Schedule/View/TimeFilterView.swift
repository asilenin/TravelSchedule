import SwiftUI

struct TimeFilterView: View {

    // MARK: - Public Properties

    @ObservedObject var viewModel: ScheduleViewModel

    // MARK: - Private Properties

    @Environment(\.dismiss) private var dismiss
    @State private var selectedDepartureTime: Set<TravelTime> = []
    @State private var selectedTransfer: TransferChoice? = nil
    @State private var showApplyButton: Bool = false

    // MARK: - Visual Components

    var body: some View {
        VStack(spacing: 0) {

            backButtonHeader

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    departureTitle

                    ForEach(TravelTime.allCases) { time in
                        TravelCheckboxView(
                            title: time.rawValue,
                            isSelected: selectedDepartureTime.contains(time)
                        ) {
                            toggleDepartureTime(time)
                        }
                    }
                    .padding(.horizontal, 16)

                    transferTitle

                    ForEach(TransferChoice.allCases) { option in
                        TravelRadioButtonView(
                            title: option.rawValue,
                            isSelected: selectedTransfer == option
                        ) {
                            selectedTransfer = option
                            updateApplyButtonVisibility()
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 95)
            }

            if showApplyButton {
                ApplyTimeFilterButton {
                    applyFilters()
                }
            }
        }
        .background(.whiteTS)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    // MARK: - Private Methods

    private var backButtonHeader: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blackTS)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var departureTitle: some View {
        Text("Время отправления")
            .font(.system(size: 24, weight: .bold))
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }

    private var transferTitle: some View {
        Text("Показывать варианты с пересадками")
            .font(.system(size: 24, weight: .bold))
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }

    private func toggleDepartureTime(_ time: TravelTime) {
        if selectedDepartureTime.contains(time) {
            selectedDepartureTime.remove(time)
        } else {
            selectedDepartureTime.insert(time)
        }

        updateApplyButtonVisibility()
    }

    private func updateApplyButtonVisibility() {
        showApplyButton = !selectedDepartureTime.isEmpty || selectedTransfer != nil
    }

    private func applyFilters() {
        viewModel.applyFilters(
            departureTimes: selectedDepartureTime,
            transferChoice: selectedTransfer
        )

        dismiss()
    }
}

// MARK: - Preview

#Preview {
    TimeFilterView(
        viewModel: ScheduleViewModel(segments: [])
    )
}
