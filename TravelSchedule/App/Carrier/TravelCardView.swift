import SwiftUI

struct TravelCardView: View {
    
    let schedule: Сarrier

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            carrierInfoSection
            timeSection
        }
        .padding(14)
        .background(.lightGrayUniversalTS)
        .cornerRadius(24)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private var carrierInfoSection: some View {
        HStack {
            CarrierLogoView(
                logoName: schedule.carrierLogoName,
                carrierName: schedule.carrierName,
                transfer: schedule.transfer
            )
            Spacer()
            Text(schedule.date)
                .foregroundColor(.blackUniversalTS)
                .font(.system(size: 12, weight: .regular))
                .kerning(0.4)
                .padding(.top, -15)
                .padding(.trailing, -7)
        }
    }
    
    private var timeSection: some View {
        HStack(alignment: .center) {
            departureTimeView
            Spacer().frame(width: 4)
            durationView
            Spacer().frame(width: 4)
            arrivalTimeView
        }
    }
    
    private var departureTimeView: some View {
        Text(schedule.departureTime)
            .foregroundColor(.blackUniversalTS)
            .font(.system(size: 17, weight: .regular))
            .kerning(-0.41)
            .frame(width: 46, alignment: .leading)
    }
    
    private var durationView: some View {
        HStack(spacing: 4) {
            Rectangle()
                .foregroundColor(.grayUniversalTS)
                .frame(height: 1)
            Text(schedule.duration)
                .foregroundColor(.blackUniversalTS)
                .font(.system(size: 12, weight: .regular))
                .fixedSize()
            Rectangle()
                .foregroundColor(.grayUniversalTS)
                .frame(height: 1)
        }
    }
    
    private var arrivalTimeView: some View {
        Text(schedule.arrivalTime)
            .foregroundColor(.blackUniversalTS)
            .font(.system(size: 17, weight: .regular))
            .kerning(-0.41)
            .frame(width: 46, alignment: .trailing)
    }
}
