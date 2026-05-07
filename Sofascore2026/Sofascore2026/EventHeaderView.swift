import UIKit
import SnapKit
import SofaAcademic

final class EventHeaderView: BaseView {

    private let homeTeamImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeStackView = UIStackView()
    
    private let guestTeamImageView = UIImageView()
    private let guestTeamNameLabel = UILabel()
    private let awayStackView = UIStackView()
    
    private let dateLabel = UILabel()
    private let scoreStackView = UIStackView()
    private let homeScoreLabel = UILabel()
    private let dashLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    private let bottomLabel = UILabel()
    
    private let centerStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    override func addViews() {
        addSubview(mainStackView)
        
        homeStackView.addArrangedSubview(homeTeamImageView)
        homeStackView.addArrangedSubview(homeTeamNameLabel)
        
        scoreStackView.addArrangedSubview(homeScoreLabel)
        scoreStackView.addArrangedSubview(dashLabel)
        scoreStackView.addArrangedSubview(awayScoreLabel)
        
        centerStackView.addArrangedSubview(dateLabel)
        centerStackView.addArrangedSubview(scoreStackView)
        centerStackView.addArrangedSubview(bottomLabel)
        
        awayStackView.addArrangedSubview(guestTeamImageView)
        awayStackView.addArrangedSubview(guestTeamNameLabel)
        
        mainStackView.addArrangedSubview(homeStackView)
        mainStackView.addArrangedSubview(centerStackView)
        mainStackView.addArrangedSubview(awayStackView)
    }
    
    override func styleViews() {
        backgroundColor = AppColors.mainBackground
        
        [homeStackView, awayStackView].forEach {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 8
        }
        
        scoreStackView.axis = .horizontal
        scoreStackView.alignment = .center
        scoreStackView.spacing = 8
        
        centerStackView.axis = .vertical
        centerStackView.alignment = .center
        centerStackView.spacing = 4
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        
        [homeTeamNameLabel, guestTeamNameLabel].forEach {
            $0.font = AppFonts.eventHeader
            $0.textColor = AppColors.primaryLabel
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        [homeTeamImageView, guestTeamImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        dateLabel.font = AppFonts.status
        dateLabel.textColor = AppColors.secondaryLabel
        dateLabel.textAlignment = .center
        
        bottomLabel.font = AppFonts.status
        bottomLabel.textAlignment = .center
        
        [homeScoreLabel, dashLabel, awayScoreLabel].forEach {
            $0.font = AppFonts.eventResult
            $0.textAlignment = .center
        }
    }
    
    override func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        homeStackView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(80)
        }
        
        awayStackView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(80)
        }
        
        centerStackView.snp.makeConstraints { make in
            make.width.equalTo(136)
        }
        
        homeTeamImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        guestTeamImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func configure(with event: Event, viewModel: EventViewModel) {
            homeTeamNameLabel.text = event.homeTeam.name
            guestTeamNameLabel.text = event.awayTeam.name
            
            homeTeamImageView.image = viewModel.homeTeamLogo
            guestTeamImageView.image = viewModel.awayTeamLogo
            
            
            dateLabel.isHidden = true
            scoreStackView.isHidden = true
            
        let liveRedColor = AppColors.red
            
            switch event.status {
            case .notStarted:
                
                dateLabel.isHidden = false
                
                dateLabel.text = viewModel.statusText
                dateLabel.textColor = AppColors.primaryLabel
                
                bottomLabel.text = viewModel.timeText
                bottomLabel.textColor = AppColors.primaryLabel
                
            case .inProgress:
          
                scoreStackView.isHidden = false
                homeScoreLabel.text = "\(event.homeScore ?? 0)"
                dashLabel.text = "-"
                awayScoreLabel.text = "\(event.awayScore ?? 0)"
                
                [homeScoreLabel, dashLabel, awayScoreLabel].forEach {
                    $0.textColor = liveRedColor
                }
                
                let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
                let minutesPassed = Int(Date().timeIntervalSince(date) / 60)
                let displayMin = minutesPassed > 0 ? "\(minutesPassed)'" : "1'"
                
                bottomLabel.text = displayMin
                bottomLabel.textColor = liveRedColor
                
            case .finished:
                
                scoreStackView.isHidden = false
                let hScore = event.homeScore ?? 0
                let aScore = event.awayScore ?? 0
                
                homeScoreLabel.text = "\(hScore)"
                dashLabel.text = "-"
                awayScoreLabel.text = "\(aScore)"
                
                dashLabel.textColor = AppColors.secondaryLabel
                bottomLabel.text = "Full Time"
                bottomLabel.font = AppFonts.status
                bottomLabel.textColor = AppColors.secondaryLabel
                
                if hScore > aScore {
                    homeScoreLabel.textColor = AppColors.primaryLabel
                    awayScoreLabel.textColor = AppColors.secondaryLabel
                } else if aScore > hScore {
                    homeScoreLabel.textColor = AppColors.secondaryLabel
                    awayScoreLabel.textColor = AppColors.primaryLabel
                } else {
                    
                    homeScoreLabel.textColor = AppColors.primaryLabel
                    awayScoreLabel.textColor = AppColors.primaryLabel
                }
                
            default:
                dateLabel.isHidden = false
                dateLabel.text = viewModel.statusText
                dateLabel.textColor = AppColors.secondaryLabel
                bottomLabel.text = ""
            }
        
        }
    }

