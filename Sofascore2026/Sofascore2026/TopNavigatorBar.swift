//
//  TopNavigatorBar.swift

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
        containerView.backgroundColor = UIColor(red: 55/255, green: 71/255, blue: 245/255, alpha: 1.0)
        
        logo.image = UIImage(named: "sofascore_logo")
            trophy.image = UIImage(named: "ic_trophy")
            settings.image = UIImage(named: "ic_settings")
    }

    override func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // rasiri se preko cijelog okvira
            make.height.equalTo(48)
        }

        
        logo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16) // 16px od lijeva
            make.centerY.equalToSuperview()           // Sredina po visini
            make.width.equalTo(100)
            make.height.equalTo(18)
        }

        
        settings.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4) // 4px od desna
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

       
        trophy.snp.makeConstraints { make in
            make.trailing.equalTo(settings.snp.leading).offset(-8) // Lijevo od postavki
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
}
