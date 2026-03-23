import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let topNavigationBar = TopNavigatorBarView()
    private let sportsCategory = SportSelectorView()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    private var sections: [(league: League, events: [Event])] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
        fetchData()
    }

    private func fetchData() {
        let dataSource = Homework3DataSource()
        let allEvents = dataSource.events()

        let grouped = Dictionary(grouping: allEvents) { $0.league?.id ?? 0 }

        self.sections = grouped.compactMap { (_, value) in
            guard let league = value.first?.league else { return nil }
            return (league: league, events: value)
        }
        .sorted { $0.league.name < $1.league.name }

        reloadLeagueCards()
    }

    private func reloadLeagueCards() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        for section in sections {
            let card = LeagueCardView()
            card.configure(with: section.league, events: section.events)
            stackView.addArrangedSubview(card)

            card.snp.makeConstraints { make in
                make.height.equalTo(288)
            }
        }
    }
}

extension ViewController: BaseViewProtocol {

    func addViews() {
        [
            topBackgroundView,
            topNavigationBar,
            sportsCategory,
            scrollView
        ].forEach { view.addSubview($0) }

        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    func styleViews() {
        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.primaryDefault

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    func setupConstraints() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(sportsCategory.snp.bottom)
        }

        topNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        sportsCategory.snp.makeConstraints { make in
            make.top.equalTo(topNavigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(sportsCategory.snp.bottom).offset(96)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
