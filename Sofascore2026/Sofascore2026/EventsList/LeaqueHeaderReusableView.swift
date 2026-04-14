import UIKit
import SnapKit
import SofaAcademic

final class LeagueHeaderReusableView: UICollectionReusableView {

    private let leagueView = LeaqueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with data: League) {
        let viewModel = LeagueViewModel(league: data)
        leagueView.configure(with: viewModel)
    }
}

extension LeagueHeaderReusableView: BaseViewProtocol {
    
    func addViews() {
        addSubview(leagueView)
    }

    func styleViews() {
        backgroundColor = .clear
    }

    func setupConstraints() {
        leagueView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
