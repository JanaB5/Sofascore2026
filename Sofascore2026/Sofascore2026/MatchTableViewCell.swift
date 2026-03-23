import UIKit
import SnapKit

final class MatchTableViewCell: UITableViewCell {

    private let matchView = MatchView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(matchView)
        selectionStyle = .none
        matchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with viewModel: EventViewModel) {
        matchView.configure(with: viewModel)
    }
}
