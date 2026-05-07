import Foundation
import UIKit
import SnapKit
import SofaAcademic

protocol TopNavigatorBarDelegate: AnyObject {
    func didTapSettings()
}

class TopNavigatorBarView: BaseView{
    
    weak var delegate: TopNavigatorBarDelegate?
    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let trophyImageView = UIImageView()
    private lazy var settingsButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "ic_settings"), for: .normal)
            button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
            return button
        }()
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(trophyImageView)
        containerView.addSubview(settingsButton)
        
    }
    
    override func styleViews() {
        containerView.backgroundColor = AppColors.primaryDefault
        logoImageView.image = UIImage(named: "sofascore_logo")
        trophyImageView.image = UIImage(named: "ic_trophy")
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }

        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-14)
            make.height.equalTo(20)
          
        }

        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
       
        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-24)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    @objc private func settingsTapped() {
            delegate?.didTapSettings()
        }
}
