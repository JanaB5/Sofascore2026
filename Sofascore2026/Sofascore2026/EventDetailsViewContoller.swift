import UIKit
import SnapKit
import SofaAcademic

final class EventDetailsViewController: UIViewController {

    private let event: Event
    private let league: League
    
    private let topBackgroundView = UIView()
    private let customNavBar = EventNavigationBarView()
    private let headerView = EventHeaderView()
    
    init(event: Event, league: League) {
        self.event = event
        self.league = league
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleViews()
        setupConstraints()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupViews() {
        view.addSubview(topBackgroundView)
        view.addSubview(customNavBar)
        view.addSubview(headerView)
    }
    
    private func styleViews() {
        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.mainBackground
    }
    
    private func setupConstraints() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(customNavBar.snp.top)
        }
        
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureData() {
            customNavBar.delegate = self
            customNavBar.configure(with: event, league: league)
            
            let eventVM = EventViewModel(event: event)
            headerView.configure(with: event, viewModel: eventVM)
        }
}

extension EventDetailsViewController: EventNavigationBarDelegate {
    func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
