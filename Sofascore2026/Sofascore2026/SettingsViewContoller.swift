import UIKit
import SnapKit
import SofaAcademic

final class SettingsViewController: UIViewController {

    private let topBackgroundView = UIView()
    private let headerContainerView = UIView()
    private let titleLabel = UILabel()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }

    private func addViews() {

        view.addSubview(topBackgroundView)
        view.addSubview(headerContainerView)
        
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(dismissButton)
    }

    private func styleViews() {

        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.primaryDefault
        headerContainerView.backgroundColor = AppColors.primaryDefault
        
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }

    private func setupConstraints() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(headerContainerView.snp.top)
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(44)
        }
    }


    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
}
