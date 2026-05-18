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
        mainStackView.distribution = .equalCentering
        
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
        }
        
        awayStackView.snp.makeConstraints { make in
            make.width.equalTo(96)
        }
        
        homeTeamImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        guestTeamImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func configure(with viewModel: EventHeaderViewModel) {
        homeTeamNameLabel.text = viewModel.homeTeamName
        guestTeamNameLabel.text = viewModel.awayTeamName
        
        homeTeamImageView.image = viewModel.homeTeamLogo
        guestTeamImageView.image = viewModel.awayTeamLogo
        
        dateLabel.isHidden = viewModel.isDateHidden
        scoreStackView.isHidden = viewModel.isScoreHidden
        
        dateLabel.text = viewModel.dateText
        if let color = viewModel.dateColor { dateLabel.textColor = color }
        
        bottomLabel.text = viewModel.bottomText
        if let color = viewModel.bottomTextColor { bottomLabel.textColor = color }
        
        homeScoreLabel.text = viewModel.homeScoreText
        if let color = viewModel.homeScoreColor { homeScoreLabel.textColor = color }
        
        dashLabel.text = viewModel.dashText
        if let color = viewModel.dashColor { dashLabel.textColor = color }
        
        awayScoreLabel.text = viewModel.awayScoreText
        if let color = viewModel.awayScoreColor { awayScoreLabel.textColor = color }
    }
}