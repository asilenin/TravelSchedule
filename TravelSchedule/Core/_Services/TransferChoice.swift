import Foundation

enum TransferChoice: String, CaseIterable, Identifiable, Sendable {
    case yes = "Да"
    case no = "Нет"

    var id: String { self.rawValue }
}
