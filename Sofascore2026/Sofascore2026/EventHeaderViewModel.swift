import UIKit
import SofaAcademic

struct EventHeaderViewModel {
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamLogo: UIImage?
    let awayTeamLogo: UIImage?
    
    let isDateHidden: Bool
    let isScoreHidden: Bool
    
    let dateText: String?
    let dateColor: UIColor?
    
    let homeScoreText: String?
    let homeScoreColor: UIColor?
    
    let dashText: String?
    let dashColor: UIColor?
    
    let awayScoreText: String?
    let awayScoreColor: UIColor?
    
    let bottomText: String?
    let bottomTextColor: UIColor?
    
    init(event: Event, eventViewModel: EventViewModel) {
        self.homeTeamName = event.homeTeam.name
        self.awayTeamName = event.awayTeam.name
        self.homeTeamLogo = eventViewModel.homeTeamLogo
        self.awayTeamLogo = eventViewModel.awayTeamLogo
        
        let liveRedColor = AppColors.red
        
        switch event.status {
        case .notStarted:
            self.isDateHidden = false
            self.isScoreHidden = true
            self.dateText = eventViewModel.statusText
            self.dateColor = AppColors.primaryLabel
            self.bottomText = eventViewModel.timeText
            self.bottomTextColor = AppColors.primaryLabel
            
            self.homeScoreText = nil
            self.homeScoreColor = nil
            self.dashText = nil
            self.dashColor = nil
            self.awayScoreText = nil
            self.awayScoreColor = nil
            
        case .inProgress:
            self.isDateHidden = true
            self.isScoreHidden = false
            self.dateText = nil
            self.dateColor = nil
            
            self.homeScoreText = "\(event.homeScore ?? 0)"
            self.dashText = "-"
            self.awayScoreText = "\(event.awayScore ?? 0)"
            
            self.homeScoreColor = liveRedColor
            self.dashColor = liveRedColor
            self.awayScoreColor = liveRedColor
            
            let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
            let minutesPassed = Int(Date().timeIntervalSince(date) / 60)
            let displayMin = minutesPassed > 0 ? "\(minutesPassed)'" : "1'"
            
            self.bottomText = displayMin
            self.bottomTextColor = liveRedColor
            
        case .finished:
            self.isDateHidden = true
            self.isScoreHidden = false
            self.dateText = nil
            self.dateColor = nil
            
            let hScore = event.homeScore ?? 0
            let aScore = event.awayScore ?? 0
            
            self.homeScoreText = "\(hScore)"
            self.dashText = "-"
            self.awayScoreText = "\(aScore)"
            
            self.dashColor = AppColors.secondaryLabel
            self.bottomText = "Full Time"
            self.bottomTextColor = AppColors.secondaryLabel
            
            if hScore > aScore {
                self.homeScoreColor = AppColors.primaryLabel
                self.awayScoreColor = AppColors.secondaryLabel
            } else if aScore > hScore {
                self.homeScoreColor = AppColors.secondaryLabel
                self.awayScoreColor = AppColors.primaryLabel
            } else {
                self.homeScoreColor = AppColors.primaryLabel
                self.awayScoreColor = AppColors.primaryLabel
            }
            
        default:
            self.isDateHidden = false
            self.isScoreHidden = true
            self.dateText = eventViewModel.statusText
            self.dateColor = AppColors.secondaryLabel
            self.bottomText = ""
            self.bottomTextColor = nil
            
            self.homeScoreText = nil
            self.homeScoreColor = nil
            self.dashText = nil
            self.dashColor = nil
            self.awayScoreText = nil
            self.awayScoreColor = nil
        }
    }
}
