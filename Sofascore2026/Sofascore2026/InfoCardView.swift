import UIKit
import SnapKit
import SofaAcademic

class InfoCardView: BaseView {
    
    private let titleLabel = UILabel()
    
    
    override func addViews() {
        addSubview(titleLabel)
    }
    
    override func styleViews() {
        backgroundColor = AppStyle.Colors.mainBackground
        titleLabel.font = AppStyle.Fonts.header
        titleLabel.textColor = AppStyle.Colors.primaryLabel
        titleLabel.numberOfLines = 0
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    
    func configure(with event: Event) {
        titleLabel.text = "\(event.homeTeam.name) vs \(event.awayTeam.name)"
    }
}
