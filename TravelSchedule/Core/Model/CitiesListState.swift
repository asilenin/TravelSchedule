enum CitiesListState: Equatable {
    case idle
    case loading
    case loaded
    case failed(ErrorViewType)
}
