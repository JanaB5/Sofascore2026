import Foundation
import SofaAcademic
import UIKit
import SnapKit

final class MatchView: BaseView {
    
    private let timeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let homeTeamImageView = UIImageView()
    private let HomeTeamName = UILabel()
    
    private let guestTeamImageView = UIImageView()
    private let guestTeamName = UILabel()
    
    private let homeResult = UILabel()
    private let guestResult = UILabel()
    
    private let lineLabel =  UIView()
    
    override func addViews() {
        [
            timeLabel,
            statusLabel,
            homeTeamImageView,
            HomeTeamName,
            guestTeamImageView ,
            guestTeamName,
            homeResult,
            guestResult,
            lineLabel
        ].forEach {
            addSubview(
                $0
            )
            }
        }
    
    override func styleViews() {
        backgroundColor = AppColors.mainBackground
        lineLabel.backgroundColor = AppColors.onSurfaceLv4
        
        timeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        timeLabel.textAlignment = .center
        timeLabel.textColor = AppColors.secondaryLabel
        
        statusLabel.font = .systemFont(ofSize: 12, weight: .regular)
        statusLabel.textAlignment = .center
        statusLabel.textColor = AppColors.secondaryLabel
        
        [HomeTeamName, guestTeamName].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = AppColors.primaryLabel
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
        }
        
        [homeResult, guestResult].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
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
            make.centerY.equalTo(HomeTeamName)
            make.leading.equalToSuperview().offset(4)
            make.width.equalTo(56)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guestTeamName)
            make.leading.equalTo(timeLabel)
            make.width.equalTo(56)
        }
        
        homeTeamImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(16)
        }
        
        HomeTeamName.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
            make.centerY.equalTo(homeTeamImageView)
            make.trailing.lessThanOrEqualTo(homeResult.snp.leading).offset(-16)
        }
        
        guestTeamImageView .snp.makeConstraints { make in
            make.leading.equalTo(homeTeamImageView)
            make.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(16)
        }
        
        guestTeamName.snp.makeConstraints { make in
            make.leading.equalTo(guestTeamImageView.snp.trailing).offset(8)
            make.centerY.equalTo(guestTeamImageView)
            make.trailing.lessThanOrEqualTo(guestResult.snp.leading).offset(-16)
        }
        
        homeResult.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(HomeTeamName)
        }
        
        guestResult.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(guestTeamName)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(64)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(1)
        }
    }
    
    func configure(with viewModel: EventViewModel) {
            HomeTeamName.text = viewModel.homeTeamName
            guestTeamName.text = viewModel.awayTeamName

            homeTeamImageView.image = viewModel.homeTeamLogo
            guestTeamImageView.image = viewModel.awayTeamLogo

            timeLabel.text = viewModel.timeText

            statusLabel.text = viewModel.statusText
            statusLabel.textColor = viewModel.statusColor

            homeResult.text = viewModel.homeScoreText
            guestResult.text = viewModel.awayScoreText

            homeResult.textColor = viewModel.homeScoreColor
            guestResult.textColor = viewModel.awayScoreColor
        }
}
