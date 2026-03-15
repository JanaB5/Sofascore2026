import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topNavigationBar = TopNavigatorBar()
    private let sportsCategory = Sportskakategorija()
    private let headerView = HeaderL()
    private let matchesStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
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
        [topNavigationBar, sportsCategory, headerView, matchesStackView].forEach {
            view.addSubview($0)
        }

        topNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        sportsCategory.snp.makeConstraints { make in
            make.top.equalTo(topNavigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        headerView.snp.makeConstraints { make in
            make.top.equalTo(sportsCategory.snp.bottom).offset(96)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
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
            let rowView = redoviView()
            rowView.configure(with: event)
            matchesStackView.addArrangedSubview(rowView)

            rowView.snp.makeConstraints { make in
                make.height.equalTo(72)
            }
        }
    }
}

