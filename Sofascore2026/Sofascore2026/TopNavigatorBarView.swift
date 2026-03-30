import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TopNavigatorBarView: BaseView{
    
    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let trophyImageView = UIImageView()
    private let settingsImageView = UIImageView()
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(trophyImageView)
        containerView.addSubview(settingsImageView)
        
    }
    
    override func styleViews() {
        containerView.backgroundColor = AppColors.primaryDefault
        logoImageView.image = UIImage(named: "sofascore_logo")
        trophyImageView.image = UIImage(named: "ic_trophy")
        settingsImageView.image = UIImage(named: "ic_settings")
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

        settingsImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
       
        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(settingsImageView.snp.leading).offset(-24)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
