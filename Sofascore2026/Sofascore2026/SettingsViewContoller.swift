import UIKit
import SnapKit
import SofaAcademic

final class SettingsViewController: UIViewController, BaseViewProtocol {

    private let topBackgroundView = UIView()
    private let headerContainerView = UIView()
    private let titleLabel = UILabel()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
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

    func addViews() {
        view.addSubview(topBackgroundView)
        view.addSubview(headerContainerView)
        
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(dismissButton)
    }

    func styleViews() {
        view.backgroundColor = AppColors.softBlue
        topBackgroundView.backgroundColor = AppColors.primaryDefault
        headerContainerView.backgroundColor = AppColors.primaryDefault
        
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }

    func setupConstraints() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(headerContainerView.snp.top)
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(dismissButton.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
    }

    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
}
