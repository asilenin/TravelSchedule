import Foundation
import Combine

@MainActor
final class AgreementViewModel: ObservableObject {

    let title = "Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц"

    let introText = """
    Данный документ является действующим, если расположен по адресу:
    https://yandex.ru/legal/practicum_offer

    Российская Федерация, город Москва
    """

    let termsTitle = "1. ТЕРМИНЫ"

    let termsText = """
    Понятия, используемые в Оферте, означают следующее:

    Авторизованные адреса — адреса электронной почты каждой Стороны...
    """
}
