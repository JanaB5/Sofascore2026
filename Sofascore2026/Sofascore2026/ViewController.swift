import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let topNavigationBar = TopNavigatorBarView()
    private let sportsCategory = SportSelectorView()
    private let headerView = LeaqueView()
    private let matchesStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.softblue
       
        setupLayout()
        setupStackView()
        fetchData()
    }

    private func setupStackView() {
        matchesStackView.axis = .vertical
        matchesStackView.spacing = 0
        matchesStackView.alignment = .fill
        matchesStackView.distribution = .fill
    }

    private func setupLayout() {
        [topBackgroundView, topNavigationBar, sportsCategory, headerView, matchesStackView].forEach {
            view.addSubview($0)
        }

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

        headerView.snp.makeConstraints { make in
            make.top.equalTo(sportsCategory.snp.bottom).offset(96)
            make.leading.trailing.equalToSuperview()
            
        }

        matchesStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            
        }
    }

    private func fetchData() {
        let dataSource = Homework2DataSource()
        let events = dataSource.laLigaEvents()

        guard let firstEvent = events.first else { return }

        if let leagueData = firstEvent.league {
            headerView.configure(with: leagueData)
        }

        events.forEach { event in
            let viewModel = EventViewModel(event: event)

            let rowView = MatchView()
            rowView.configure(with: viewModel)
            matchesStackView.addArrangedSubview(rowView)

        }
    }
}
