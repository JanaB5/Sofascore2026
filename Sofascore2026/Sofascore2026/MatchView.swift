import Foundation
import SofaAcademic
import UIKit
import SnapKit

final class MatchView: BaseView {
    
    private let timeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let homeTeamImageView = UIImageView()
    private let HomeTeamNameLabel = UILabel()
    
    private let guestTeamImageView = UIImageView()
    private let guestTeamNameLabel = UILabel()
    
    private let homeResultLabel = UILabel()
    private let guestResultLabel = UILabel()
    
    private let lineView =  UIView()
    
    override func addViews() {
        [
            timeLabel,
            statusLabel,
            homeTeamImageView,
            HomeTeamNameLabel,
            guestTeamImageView,
            guestTeamNameLabel,
            homeResultLabel,
            guestResultLabel,
            lineView
        ].forEach { addSubview($0) }
        }
    
    override func styleViews() {
        backgroundColor = AppColors.mainBackground
        lineView.backgroundColor = AppColors.onSurfaceLv4
        
        timeLabel.font = AppFonts.robotoCondensed(size: 12)
        timeLabel.textAlignment = .center
        timeLabel.textColor = AppColors.secondaryLabel
        
        statusLabel.font = AppFonts.robotoCondensed(size: 12)
        statusLabel.textAlignment = .center
        statusLabel.textColor = AppColors.secondaryLabel
        
        [HomeTeamNameLabel, guestTeamNameLabel].forEach {
            $0.font = AppFonts.robotoRegular(size: 14)
            $0.textColor = AppColors.primaryLabel
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
        }
        
        [homeResultLabel, guestResultLabel].forEach {
            $0.font = AppFonts.robotoRegular(size: 14)
            $0.textAlignment = .right
            $0.textColor = AppColors.primaryLabel
        }
        
        [homeTeamImageView, guestTeamImageView ].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }
    
    override func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(HomeTeamNameLabel)
            make.leading.equalToSuperview().offset(4)
            make.width.equalTo(56)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guestTeamNameLabel)
            make.leading.equalTo(timeLabel)
            make.width.equalTo(56)
        }
        
        homeTeamImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(16)
        }
        
        HomeTeamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
            make.centerY.equalTo(homeTeamImageView)
            make.trailing.lessThanOrEqualTo(homeResultLabel.snp.leading).offset(-16)
        }
        
        guestTeamImageView.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamImageView)
            make.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(16)
        }
        
        guestTeamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(guestTeamImageView.snp.trailing).offset(8)
            make.centerY.equalTo(guestTeamImageView)
            make.trailing.lessThanOrEqualTo(guestResultLabel.snp.leading).offset(-16)
        }
        
        homeResultLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(HomeTeamNameLabel)
        }
        
        guestResultLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(guestTeamNameLabel)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(64)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(1)
        }
    }
    
    func configure(with viewModel: EventViewModel) {
            HomeTeamNameLabel.text = viewModel.homeTeamName
            guestTeamNameLabel.text = viewModel.awayTeamName

            homeTeamImageView.image = viewModel.homeTeamLogo
            guestTeamImageView.image = viewModel.awayTeamLogo

            timeLabel.text = viewModel.timeText

            statusLabel.text = viewModel.statusText
            statusLabel.textColor = viewModel.statusColor

            homeResultLabel.text = viewModel.homeScoreText
            guestResultLabel.text = viewModel.awayScoreText

            homeResultLabel.textColor = viewModel.homeScoreColor
            guestResultLabel.textColor = viewModel.awayScoreColor
        }
}
