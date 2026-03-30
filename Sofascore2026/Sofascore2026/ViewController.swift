import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let topNavigationBar = TopNavigatorBarView()
    private let sportsCategory = SportSelectorView()

    private var collectionView: UICollectionView!
    private var sections: [(league: League, events: [Event])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addViews()
        styleViews()
        setupConstraints()
        fetchData()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SpacerCell")
        collectionView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: "MatchCell")
        collectionView.register(LeagueHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LeagueHeader")
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

        collectionView.reloadData()
    }
}

extension ViewController: BaseViewProtocol {

    func addViews() {
        [topBackgroundView, topNavigationBar, sportsCategory, collectionView].forEach {
            view.addSubview($0)
        }
    }

    func styleViews() {
        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.primaryDefault
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

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sportsCategory.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return sections[section - 1].events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpacerCell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as? MatchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = sections[indexPath.section - 1].events[indexPath.row]
        cell.configure(with: EventViewModel(event: event))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueHeader", for: indexPath) as? LeagueHeaderReusableView else {
            return UICollectionReusableView()
        }

        header.configure(with: sections[indexPath.section - 1].league)
        return header
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 96)
        }
        return CGSize(width: width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
