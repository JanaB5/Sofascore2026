import UIKit
import SnapKit
import SofaAcademic

final class LeagueCardView: UIView {

    private let headerView = LeagueHeaderReusableView()
    private let tableView = UITableView()

    private var events: [Event] = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(headerView)
        addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchTableViewCell")

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) { fatalError() }

    func configure(with league: League, events: [Event]) {
        headerView.configure(with: league)
        self.events = events
        tableView.setContentOffset(.zero, animated: false)
        tableView.reloadData()
    }
}

extension LeagueCardView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        cell.configure(with: EventViewModel(event: events[indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }
}
