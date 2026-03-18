import UIKit
import SnapKit
import SofaAcademic

class SportSelectorView: BaseView {
    
    private let stackView = UIStackView()
    private let footballTab = SportItemView()
    private let basketballTab = SportItemView()
    private let amFootballTab = SportItemView()

    override func addViews() {
        addSubview(stackView)
      
        stackView.addArrangedSubview(footballTab)
        stackView.addArrangedSubview(basketballTab)
        stackView.addArrangedSubview(amFootballTab)
    }

    override func styleViews() {
        
        stackView.backgroundColor = AppColors.viewBackground
        stackView.axis = .horizontal       //  vodoravno
        stackView.distribution = .fillEqually // svi iste širine (onih 120px)
        stackView.alignment = .center
        
        footballTab.configure(name: "Football", imageName: "football")
        basketballTab.configure(name: "Basketball", imageName: "basketball")
        amFootballTab.configure(name: "Am. Football", imageName: "amfootball")
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview() 
         
        }
    }
}
