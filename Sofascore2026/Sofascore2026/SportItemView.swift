import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SportItemView: BaseView {
    private let icon = UIImageView()
    private let label = UILabel()
    private let selectedBar = UIView() 

    override func addViews() {
        addSubview(icon)
        addSubview(label)
        addSubview(selectedBar)
    }

    override func styleViews() {
        icon.contentMode = .scaleAspectFit
        
        label.textColor = AppColors.mainBackground
        label.textAlignment = .center
        label.font = AppFonts.robotoRegular(size: 14)
        
        selectedBar.backgroundColor = AppColors.mainBackground
        selectedBar.isHidden = true
        selectedBar.layer.cornerRadius = 2
            selectedBar.clipsToBounds = true
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
            make.bottom.equalToSuperview().offset(-8) // Malo smanjen offset da stane linija
        }
        
        
        selectedBar.snp.makeConstraints { make in
            
            make.width.equalToSuperview().multipliedBy(0.86)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }

    func configure(name: String, imageName: String) {
        label.text = name
        icon.image = UIImage(named: imageName)
    }
    
    
    func setSelected(_ isSelected: Bool) {
        selectedBar.isHidden = !isSelected
    }
}
