import UIKit
import SnapKit
import SofaAcademic

class LeaqueView: BaseView {
  
    private let leagueIcon = UIImageView()
    private let countryLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let leagueLabel = UILabel()
    
    override func addViews() {
        addSubview(leagueIcon)
        addSubview(countryLabel)
        addSubview(arrowImageView)
        addSubview(leagueLabel)
    }
    
    override func styleViews() {
        backgroundColor = AppColors.mainBackground
        leagueIcon.contentMode = .scaleAspectFit
        
        countryLabel.font = AppFonts.robotoBold(size: 14)
        countryLabel.textColor = AppColors.primaryLabel
        
        arrowImageView.image = UIImage(named: "arrow")
        arrowImageView.contentMode = .scaleAspectFit
        
        leagueLabel.font = AppFonts.robotoRegular(size: 14)
        leagueLabel.textColor = AppColors.secondaryLabel
    }
    
    override func setupConstraints() {
        leagueIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.size.equalTo(32)
        }

        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueIcon.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(countryLabel.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        leagueLabel.snp.makeConstraints { make in
            make.leading.equalTo(arrowImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.height.equalTo(16)
        }
    }
    
    func configure(with viewModel: LeagueViewModel) {
        countryLabel.text = viewModel.countryName
        leagueLabel.text = viewModel.leagueName
        leagueIcon.image = viewModel.leagueLogo
    }
}
