import UIKit
import SnapKit
import SofaAcademic

class HeaderL: BaseView {
  
    private let leagueIcon = UIImageView()
    private let titleLabel = UILabel()
    
   
    override func addViews() {
        addSubview(leagueIcon)
        addSubview(titleLabel)
    }
    
   
    override func styleViews() {
        backgroundColor = .white
   
        leagueIcon.image = UIImage(named: "logo_laliga")
        leagueIcon.contentMode = .scaleAspectFit
        
        titleLabel.font = AppStyle.Fonts.bold(size: 14)
        titleLabel.textColor = AppStyle.Colors.secondaryLabel
    }
    
   
    override func setupConstraints() {
        leagueIcon.snp.makeConstraints { make in
           
         
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueIcon.snp.trailing).offset(32)
            make.centerY.equalTo(leagueIcon)
            
            make.trailing.lessThanOrEqualToSuperview().offset(-129)
            
        }
    }
    
    // 5. Spajamo s podacima
    func configure(with league: League) {
        let countryName = league.country?.name ?? "Unknown"
        let separatorAndLeague = " > \(league.name)"
        
        let fullText = NSMutableAttributedString(
            string: countryName,
            attributes: [
                .font: AppStyle.Fonts.bold(size: 14),
                .foregroundColor: UIColor.black
            ]
        )
        
        let secondPart = NSAttributedString(
            string: separatorAndLeague,
            attributes: [
                .font: AppStyle.Fonts.regular(size: 14),
                .foregroundColor: AppStyle.Colors.secondaryLabel
            ]
        )
        
        fullText.append(secondPart)
        titleLabel.attributedText = fullText
    }
}
