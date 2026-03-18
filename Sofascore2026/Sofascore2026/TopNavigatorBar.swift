import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TopNavigatorBar: BaseView{
    
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
            make.edges.equalToSuperview() // rasiri se preko cijelog okvira
            
        }

        logo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16) // 16px od lijeva
            make.centerY.equalToSuperview()
            make.width.equalTo(130)// Sredina po visini
            make.height.equalTo(20)
          
        }

        settings.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16) // 4px od desna
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
       
        trophy.snp.makeConstraints { make in
            make.trailing.equalTo(settings.snp.leading).offset(-24) // Lijevo postavki
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
}
