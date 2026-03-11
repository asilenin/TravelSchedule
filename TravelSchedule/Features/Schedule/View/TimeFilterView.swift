import SwiftUI

struct TimeFilterView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var selectedDepartureTime: Set<TravelTime> = []
    @State private var selectedTransfer: TransferChoice? = nil
    @State private var showApplyButton: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blackTS)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    
                    ForEach(TravelTime.allCases) { time in
                        TravelCheckboxView(
                            title: time.rawValue,
                            isSelected: selectedDepartureTime.contains(time)
                        ) {
                            if selectedDepartureTime.contains(time) {
                                selectedDepartureTime.remove(time)
                            } else {
                                selectedDepartureTime.insert(time)
                            }
                            updateApplyButtonVisibility()
                        }
                    }
                    .padding(.horizontal, 16)
                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    
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
                ApplyTimeFilterButton(action: {
                    applyFilters()
                })
            }
        }
        .background(.whiteTS)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
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

#Preview {
    TimeFilterView(viewModel: ScheduleViewModel(segments: []))
}
