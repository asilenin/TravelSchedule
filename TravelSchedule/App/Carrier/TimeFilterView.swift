import SwiftUI

struct TimeFilterView: View {
    @State private var selectedDepartureTime: Set<TravelTime> = []
    @State private var selectedTransfer: TransferChoice? = nil
    @State private var showApplyButton: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            NavigationView(title: "", showBackButton: true, backAction: {
                dismiss()
            })
            
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
            
            // MARK: - Apply Button
            if showApplyButton {
                ApplyTimeFilterButton{
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
    
    private func updateApplyButtonVisibility() {
        showApplyButton = !selectedDepartureTime.isEmpty || selectedTransfer != nil
    }
    
    private func applyFilters() {
        print("Применены фильтры:")
        print("  Время отправления: \(selectedDepartureTime.map { $0.rawValue }.joined(separator: ", "))")
        print("  Варианты с пересадками: \(selectedTransfer?.rawValue ?? "Не выбрано")")
        dismiss()
    }
}

#Preview {
    TimeFilterView()
}
