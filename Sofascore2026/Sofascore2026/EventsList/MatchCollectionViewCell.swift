import UIKit
import SnapKit
import SofaAcademic

final class MatchCollectionViewCell: UICollectionViewCell {
    
    private let matchView = MatchView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with viewModel: EventViewModel) {
        matchView.configure(with: viewModel)
    }
}

extension MatchCollectionViewCell: BaseViewProtocol {
    
    func addViews() {
        contentView.addSubview(matchView)
    }

    func styleViews() {
        backgroundColor = .clear
    }

    func setupConstraints() {
        matchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
