import Foundation

enum TransferChoice: String, CaseIterable, Identifiable {
    case yes = "Да"
    case no = "Нет"

    var id: String { self.rawValue }
}
