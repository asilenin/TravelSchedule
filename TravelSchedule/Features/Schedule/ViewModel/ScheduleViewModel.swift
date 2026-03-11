import SwiftUI
import Combine

@MainActor
final class ScheduleViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded([Components.Schemas.Segment])
        case error(String)
    }
    
    @Published private(set) var state: State = .idle
    
    private let allSegments: [Components.Schemas.Segment]

    
    init(segments: [Components.Schemas.Segment]) {
        self.allSegments = segments
        self.state = .loaded(segments)
    }
    
    func applyFilters(
        departureTimes: Set<TravelTime>,
        transferChoice: TransferChoice?
    ) {
        var filtered = allSegments

        // Filter by transfers
        if let transferChoice {
            switch transferChoice {
            case .yes:
                filtered = filtered.filter { ($0.transfers ?? 0) == 0 }
            case .no:
                filtered = filtered.filter { ($0.transfers ?? 0) > 0 }
            }
        }

        // Filter by departure time ranges
        if !departureTimes.isEmpty {
            filtered = filtered.filter { segment in
                guard let departure = segment.departure,
                      let hour = extractHour(from: departure) else { return false }
                for time in departureTimes {
                    switch time {
                    case .morning:
                        if hour >= 6 && hour < 12 { return true }
                    case .day:
                        if hour >= 12 && hour < 18 { return true }
                    case .evening:
                        if hour >= 18 && hour < 24 { return true }
                    case .night:
                        if hour >= 0 && hour < 6 { return true }
                    }
                }
                return false
            }
        }
        state = .loaded(filtered)
    }
    
    private func extractHour(from timeString: String) -> Int? {
        if let tIndex = timeString.firstIndex(of: "T") {
            let timePart = timeString[timeString.index(after: tIndex)...]
            let hourString = timePart.prefix(2)
            return Int(hourString)
        }

        let components = timeString.split(separator: ":")
        if let first = components.first {
            return Int(first)
        }

        return nil
    }
    
    func makeCarrierInfo(from segment: Components.Schemas.Segment) -> CarrierInfo {
        let carrier = segment.thread?.carrier
        
        let carrierTitle = (carrier?.title ?? "Перевозчик")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let carrierLogo = (carrier?.logo ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let carrierEmail = (carrier?.email ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let carrierPhone = (carrier?.phone ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)


        return CarrierInfo(
            carrierLogoName: carrierLogo,
            carrierFullName: carrierTitle.isEmpty ? "Перевозчик" : carrierTitle,
            email: carrierEmail,
            phone: carrierPhone
        )
    }
}
