
enum Sport: CaseIterable {
    case football
    case basketball
    case amFootball

    var viewModel: SportItemViewModel {
        switch self {
        case .football:
            return SportItemViewModel(name: AppStrings.football, imageName: "football")
        case .basketball:
            return SportItemViewModel(name: AppStrings.basketball, imageName: "basketball")
        case .amFootball:
            return SportItemViewModel(name: AppStrings.amFootball, imageName: "amfootball")
        }
    }
}
