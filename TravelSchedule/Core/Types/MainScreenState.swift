enum MainScreenState: Equatable {
    
    case idle
    case loading
    case loaded(Components.Schemas.Segments)
    case failed(ErrorViewType)
}
