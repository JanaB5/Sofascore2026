import UIKit
import SnapKit
import SofaAcademic

class StatusView: BaseView {
    
    private let statusLabel = UILabel()
    private let timeLabel = UILabel()
    
    override func addViews() {
        addSubview(statusLabel)
        addSubview(timeLabel)
    }
    
    override func styleViews() {
        statusLabel.font = AppStyle.Fonts.bold(size: 14)
        timeLabel.font = AppStyle.Fonts.regular(size: 14)
    }
    
    override func setupConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with event: Event) {
        statusLabel.text = "Status: \(event.status)"
        
       
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        timeLabel.text = AppStyle.Formatters.date.string(from: date)
    }
}
