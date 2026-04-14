import UIKit
import SnapKit
import SofaAcademic

final class FooterView: UICollectionReusableView, BaseViewProtocol {

    private let dividerView: UIView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(dividerView)
    }

    func styleViews() {
        backgroundColor = AppColors.mainBackground
        dividerView.backgroundColor = AppColors.primaryDefault
    }

    func configure(isLast: Bool) {
        dividerView.backgroundColor = isLast ? .clear : AppColors.softBlue
    }

    func setupConstraints() {
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
