import SwiftUI

struct TravelCardView: View {

    // MARK: - Public Properties

    let segment: Components.Schemas.Segment

    // MARK: - Visual Components

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

    // MARK: - Private Methods

    private var carrierInfoSection: some View {
        HStack {
            CarrierLogoView(
                logoURL: carrierLogoURL,
                carrierName: carrierName,
                transfer: hasTransfers ? "С пересадкой" : ""
            )
            Spacer()
            Text(formattedDate)
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
        Text(departureTime)
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

            Text(durationText)
                .foregroundColor(.blackUniversalTS)
                .font(.system(size: 12, weight: .regular))
                .fixedSize()

            Rectangle()
                .foregroundColor(.grayUniversalTS)
                .frame(height: 1)
        }
    }

    private var arrivalTimeView: some View {
        Text(arrivalTime)
            .foregroundColor(.blackUniversalTS)
            .font(.system(size: 17, weight: .regular))
            .kerning(-0.41)
            .frame(width: 46, alignment: .trailing)
    }
}

// MARK: - Private Methods

private extension TravelCardView {

    var carrierName: String {
        segment.thread?.carrier?.title ?? "—"
    }

    var carrierLogoURL: String? {
        segment.thread?.carrier?.logo
    }

    var hasTransfers: Bool {
        (segment.transfers ?? 0) > 0
    }

    var departureTime: String {
        formatTime(segment.departure)
    }

    var arrivalTime: String {
        formatTime(segment.arrival)
    }

    var durationText: String {
        guard let duration = segment.duration else { return "" }

        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        var components: [String] = []

        if hours > 0 {
            components.append("\(hours) \(hoursWord(hours))")
        }

        if minutes > 0 {
            components.append("\(minutes) \(minutesWord(minutes))")
        }

        return components.joined(separator: " ")
    }

    var formattedDate: String {
        formatDate(segment.start_date)
    }

    func hoursWord(_ value: Int) -> String {
        switch value % 10 {
        case 1 where value % 100 != 11: return "час"
        case 2...4 where !(12...14).contains(value % 100): return "часа"
        default: return "часов"
        }
    }

    func minutesWord(_ value: Int) -> String {
        switch value % 10 {
        case 1 where value % 100 != 11: return "минута"
        case 2...4 where !(12...14).contains(value % 100): return "минуты"
        default: return "минут"
        }
    }

    func formatTime(_ timeString: String?) -> String {
        guard let timeString else { return "" }

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: timeString) else {
            print("Failed to parse time:", timeString)
            return timeString
        }

        let output = DateFormatter()
        output.dateFormat = "HH:mm"
        output.locale = Locale(identifier: "ru_RU")

        return output.string(from: date)
    }

    func formatDate(_ iso: String?) -> String {
        guard let iso else { return "" }

        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"
        input.locale = Locale(identifier: "en_US_POSIX")

        guard let date = input.date(from: iso) else {
            print("Failed to parse date:", iso)
            return ""
        }

        let output = DateFormatter()
        output.locale = Locale(identifier: "ru_RU")
        output.dateFormat = "d MMMM"

        return output.string(from: date)
    }
}
