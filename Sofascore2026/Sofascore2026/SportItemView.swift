import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SportItemView: BaseView {
    private let icon = UIImageView()
    private let label = UILabel()

    override func addViews() {
        addSubview(icon)
        addSubview(label)
    }

    override func styleViews() {
        icon.contentMode = .scaleAspectFit
        
        label.textColor = AppColors.mainBackground
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
    }

    override func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(4) 
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-4)
        }
    }

    func configure(name: String, imageName: String) {
        label.text = name
        icon.image = UIImage(named: imageName)
    }
}
