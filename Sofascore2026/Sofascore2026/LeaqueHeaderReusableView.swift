import UIKit
import SnapKit
import SofaAcademic

final class LeagueHeaderReusableView: UICollectionReusableView {

    private let leagueView = LeaqueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupHeader() {
        addSubview(leagueView)

        leagueView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with data: League) {
        leagueView.configure(with: data)
    }
}
