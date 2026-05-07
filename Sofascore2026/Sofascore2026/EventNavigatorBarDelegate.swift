import UIKit
import SnapKit
import SofaAcademic

protocol EventNavigationBarDelegate: AnyObject {
    func didTapBack()
}

final class EventNavigationBarView: BaseView {
    
    weak var delegate: EventNavigationBarDelegate?
    
    private let containerView = UIView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = AppColors.primaryLabel
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let infoStackView = UIStackView()
    private let leagueIconImageView = UIImageView()
    private let detailsLabel = UILabel()
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(backButton)
        
        infoStackView.addArrangedSubview(leagueIconImageView)
        infoStackView.addArrangedSubview(detailsLabel)
        containerView.addSubview(infoStackView)
    }
    
    override func styleViews() {
        backgroundColor = AppColors.mainBackground
        
        infoStackView.axis = .horizontal
        infoStackView.spacing = 8
        infoStackView.alignment = .center
        
        leagueIconImageView.contentMode = .scaleAspectFit
        leagueIconImageView.clipsToBounds = true
        
        detailsLabel.font = AppFonts.robotoRegular(size: 12)
        detailsLabel.textColor = AppColors.secondaryLabel
        detailsLabel.numberOfLines = 1
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(44)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        leagueIconImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
    
    @objc private func backButtonTapped() {
        delegate?.didTapBack()
    }
    
    func configure(with event: Event, league: League) {
            let leagueVM = LeagueViewModel(league: league)
            
            let sportName = "Football"
            let countryName = leagueVM.countryName ?? ""
            let leagueName = leagueVM.leagueName ?? ""
            
            let navBarText = [sportName, countryName, leagueName]
                .filter { !$0.isEmpty }
                .joined(separator: ", ")
            
            detailsLabel.text = navBarText
            leagueIconImageView.image = leagueVM.leagueLogo
        }
}
