import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let topNavigationBar = TopNavigatorBarView()
    private let sportsCategory = SportSelectorView()
    private let leagueView = LeaqueView()
    private let matchesStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        fetchData()
    }

    private func fetchData() {
        let dataSource = Homework2DataSource()
        let events = dataSource.laLigaEvents()

        if let firstEvent = events.first, let leagueData = firstEvent.league {
            leagueView.configure(with: leagueData)
        }

        events.forEach { event in
            let viewModel = EventViewModel(event: event)
            let rowView = MatchView()
            rowView.configure(with: viewModel)
            matchesStackView.addArrangedSubview(rowView)
        }
    }
}

extension ViewController: BaseViewProtocol {

    func addViews() {
        [topBackgroundView, topNavigationBar, sportsCategory, leagueView, matchesStackView].forEach {
            view.addSubview($0)
        }
    }

    func styleViews() {
        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.primaryDefault
        
        matchesStackView.axis = .vertical
        matchesStackView.spacing = 0
        matchesStackView.alignment = .fill
        matchesStackView.distribution = .fill
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

        leagueView.snp.makeConstraints { make in
            make.top.equalTo(sportsCategory.snp.bottom).offset(96)
            make.leading.trailing.equalToSuperview()
        }

        matchesStackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
