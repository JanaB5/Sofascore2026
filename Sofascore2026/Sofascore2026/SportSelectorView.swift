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
        stackView.backgroundColor = AppColors.primaryDefault
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill 
        
        footballTab.configure(name: "Football", imageName: "football")
        basketballTab.configure(name: "Basketball", imageName: "basketball")
        amFootballTab.configure(name: "Am. Football", imageName: "amfootball")
        selectTab(footballTab)
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

  
    override func setupGestureRecognizers() {
        footballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(footballTapped)))
        basketballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(basketballTapped)))
        amFootballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(amFootballTapped)))
    }

   
    @objc private func footballTapped() { selectTab(footballTab) }
    @objc private func basketballTapped() { selectTab(basketballTab) }
    @objc private func amFootballTapped() { selectTab(amFootballTab) }

    
    private func selectTab(_ selectedTab: SportItemView) {
        let tabs = [footballTab, basketballTab, amFootballTab]
        for tab in tabs {
            if tab === selectedTab {
                tab.setSelected(true)
            } else {
                tab.setSelected(false)
            }
        }
    }
}
