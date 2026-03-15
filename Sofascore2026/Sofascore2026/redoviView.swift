import Foundation
import SofaAcademic
import UIKit
import SnapKit

final class redoviView: BaseView {
    
    private let vrijeme = UILabel()
    private let status = UILabel()
    
    private let grb = UIImageView()
    private let imedomacina = UILabel()
    
    private let grbgost = UIImageView()
    private let imegosta = UILabel()
    
    private let rezdomacin = UILabel()
    private let rezgost = UILabel()
    
    private let linija =  UIView()
    
    
    override func addViews() {
        [vrijeme, status, grb, imedomacina, grbgost, imegosta, rezdomacin, rezgost, linija].forEach {
            addSubview($0)
        }
    }
    
    override func styleViews() {
        backgroundColor = .white
        linija.backgroundColor = .lightGray
        
        vrijeme.font = .systemFont(ofSize: 12, weight: .regular)
        vrijeme.textAlignment = .center
        vrijeme.textColor = .lightGray
        
        status.font = .systemFont(ofSize: 12, weight: .regular)
        status.textAlignment = .center
        status.textColor = .gray
        
        [imedomacina, imegosta].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .black
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
        }
        
        [rezdomacin, rezgost].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textAlignment = .right
            $0.textColor = .black
        }
        
        [grb, grbgost].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }
    
    override func setupConstraints() {
        vrijeme.snp.makeConstraints { make in
            make.centerY.equalTo(imedomacina)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(56)
        }
        
        status.snp.makeConstraints { make in
            make.centerY.equalTo(imegosta)
            make.leading.equalTo(vrijeme)
            make.width.equalTo(56)
        }
        
        grb.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(72)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(16)
        }
        
        imedomacina.snp.makeConstraints { make in
            make.leading.equalTo(grb.snp.trailing).offset(8)
            make.centerY.equalTo(grb)
            make.trailing.lessThanOrEqualTo(rezdomacin.snp.leading).offset(-8)
        }
        
        grbgost.snp.makeConstraints { make in
            make.leading.equalTo(grb)
            make.top.equalTo(grb.snp.bottom).offset(10)
            make.size.equalTo(16)
        }
        
        imegosta.snp.makeConstraints { make in
            make.leading.equalTo(grbgost.snp.trailing).offset(8)
            make.centerY.equalTo(grbgost)
            make.trailing.lessThanOrEqualTo(rezgost.snp.leading).offset(-16)
        }
        
        rezdomacin.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(imedomacina)
        }
        
        rezgost.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(imegosta)
        }
        
      
        
        grbgost.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        linija.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(64)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(1)
        }
    }
    
    func configure(with event: Event) {
        imedomacina.text = event.homeTeam.name
        imegosta.text = event.awayTeam.name
        grb.image = logoImage(for: event.homeTeam.name)
        grbgost.image = logoImage(for: event.awayTeam.name)
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        vrijeme.text = formatter.string(from: date)
        vrijeme.textColor = .lightGray
        
        switch event.status {
        case .notStarted:
            status.text = "-"
            status.textColor = .gray
            
            rezdomacin.text = ""
            rezgost.text = ""
            rezdomacin.textColor = .black
            rezgost.textColor = .black
            
        case .inProgress:
            status.text = liveMatchMinuteText(from: event.startTimestamp)
            status.textColor = .red
            
            
            rezdomacin.text = "\(event.homeScore ?? 0)"
            rezgost.text = "\(event.awayScore ?? 0)"
            rezdomacin.textColor = .red
            rezgost.textColor = .red
            
        case .finished:
            status.text = "FT"
            status.textColor = .gray
            
            let homeScore = event.homeScore ?? 0
                    let awayScore = event.awayScore ?? 0
                    
                    rezdomacin.text = "\(homeScore)"
                    rezgost.text = "\(awayScore)"
                    
                    if homeScore > awayScore {
                        rezdomacin.textColor = .black
                        rezgost.textColor = .lightGray
                    } else if awayScore > homeScore {
                        rezdomacin.textColor = .lightGray
                        rezgost.textColor = .black
                    } else {
                        rezdomacin.textColor = .black
                        rezgost.textColor = .black
                    }
            
            
        default:
            status.text = "-"
            status.textColor = .gray
            
            rezdomacin.text = ""
            rezgost.text = ""
            rezdomacin.textColor = .black
            rezgost.textColor = .black
        }
    }
    private func logoImage(for teamName: String) -> UIImage? {
        switch teamName {
        case "Real Madrid":
            return UIImage(named: "realmadrid")
        case "Barcelona":
            return UIImage(named: "barcelona")
        case "Villareal":
            return UIImage(named: "villareal")
        case "Mallorca":
            return UIImage(named: "mallorca")
        default:
            return nil
        }
    }
    private func liveMatchMinuteText(from timestamp: Int) -> String {
           let startDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
           let currentDate = Date()

           let minutes = Int(currentDate.timeIntervalSince(startDate) / 60)
           let safeMinutes = max(1, minutes)

           return "\(safeMinutes)'"
       }
    private func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func formattedStatus(from status: EventStatus) -> String {
        String(describing: status).uppercased()
    }
}
