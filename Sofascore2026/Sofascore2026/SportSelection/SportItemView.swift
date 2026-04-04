import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SportItemView: BaseView {
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let selectedIndicatorView = UIView()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(selectedIndicatorView)
    }

    override func styleViews() {
        iconImageView.contentMode = .scaleAspectFit
        
        nameLabel.textColor = AppColors.mainBackground
        nameLabel.textAlignment = .center
        nameLabel.font = AppFonts.robotoRegular(size: 14)
        
        selectedIndicatorView.backgroundColor = AppColors.mainBackground
        selectedIndicatorView.isHidden = true
        selectedIndicatorView.layer.cornerRadius = 2
        selectedIndicatorView.clipsToBounds = true
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.size.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(16)
        }
        
        selectedIndicatorView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.86)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }

    func configure(with viewModel: SportItemViewModel) {
        nameLabel.text = viewModel.name
        iconImageView.image = UIImage(named: viewModel.imageName)
    }
    
    func setSelected(_ isSelected: Bool) {
        selectedIndicatorView.isHidden = !isSelected
    }
}
