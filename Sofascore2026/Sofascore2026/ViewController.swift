import UIKit
import SnapKit
import SofaAcademic

final class ViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let topNavigationBar = TopNavigatorBarView()
    private let sportsCategory = SportSelectorView()
    private var sections: [(league: League, events: [Event])] = []
    private let initialTopSpacing: CGFloat = 96
    private var collectionTopConstraint: Constraint?
    
    private var flowLayout: UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionHeadersPinToVisibleBounds = true
            layout.minimumLineSpacing = 0
            return layout
        }
        private lazy var collectionView: UICollectionView = .init(
            frame: .zero,
            collectionViewLayout: flowLayout
        )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addViews()
        styleViews()
        setupConstraints()
        fetchData()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        
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
            self.collectionTopConstraint = make.top.equalTo(sportsCategory.snp.bottom).offset(initialTopSpacing).constraint
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as? MatchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = sections[indexPath.section].events[indexPath.row]
        cell.configure(with: EventViewModel(event: event))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueHeader", for: indexPath) as? LeagueHeaderReusableView else {
            return UICollectionReusableView()
        }

        header.configure(with: sections[indexPath.section].league)
        return header
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        return CGSize(width: width, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = max(0, initialTopSpacing - scrollView.contentOffset.y)
        collectionTopConstraint?.update(offset: offset)
    }
}
