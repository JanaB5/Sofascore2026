import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TopNavigatorBarView: BaseView{
    
    private let containerView = UIView()
    private let logo = UIImageView()
    private let trophy = UIImageView()
    private let settings = UIImageView()
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(logo)
        containerView.addSubview(trophy)
        containerView.addSubview(settings)
        
    }
    
    override func styleViews() {
        
        containerView.backgroundColor = AppColors.viewBackground
        
        logo.image = UIImage(named: "sofascore_logo")
        trophy.image = UIImage(named: "ic_trophy")
        settings.image = UIImage(named: "ic_settings")
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }

        logo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-14)
            make.height.equalTo(20)
          
        }

        settings.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
       
        trophy.snp.makeConstraints { make in
            make.trailing.equalTo(settings.snp.leading).offset(-24)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
