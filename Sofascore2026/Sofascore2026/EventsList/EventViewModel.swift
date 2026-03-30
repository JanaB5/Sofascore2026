import Foundation
import SofaAcademic
import UIKit

struct EventViewModel {
    let timeText: String
    let statusText: String
    let statusColor: UIColor
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamLogo: UIImage?
    let awayTeamLogo: UIImage?
    let homeScoreText: String
    let awayScoreText: String
    let homeScoreColor: UIColor
    let awayScoreColor: UIColor

    init(event: Event) {
        self.homeTeamName = event.homeTeam.name
        self.awayTeamName = event.awayTeam.name
        self.homeTeamLogo = EventViewModel.logoImage(for: event.homeTeam.name)
        self.awayTeamLogo = EventViewModel.logoImage(for: event.awayTeam.name)
        self.timeText = EventViewModel.formatTime(from: event.startTimestamp)
        
        self.statusText = EventViewModel.setupStatusText(event: event)
        self.statusColor = EventViewModel.setupStatusColor(event: event)
        
        let scoreData = EventViewModel.setupScores(event: event)
        self.homeScoreText = scoreData.homeText
        self.awayScoreText = scoreData.awayText
        self.homeScoreColor = scoreData.homeColor
        self.awayScoreColor = scoreData.awayColor
    }

    private static func setupStatusText(event: Event) -> String {
        switch event.status {
        case .notStarted:
            return AppStrings.dash
        case .inProgress:
            return liveMatchMinuteText(from: event.startTimestamp)
        case .finished:
            return AppStrings.fullTime
        default:
            return AppStrings.dash
        }
    }

    private static func setupStatusColor(event: Event) -> UIColor {
        if event.status == .inProgress {
            return AppColors.red
        }
        return AppColors.secondaryLabel
    }

    private static func setupScores(event: Event) -> (homeText: String, awayText: String, homeColor: UIColor, awayColor: UIColor) {
        let homeScore = event.homeScore ?? 0
        let awayScore = event.awayScore ?? 0

        switch event.status {
        case .notStarted:
            return (AppStrings.empty, AppStrings.empty, AppColors.primaryLabel, AppColors.primaryLabel)
            
        case .inProgress:
            return ("\(homeScore)", "\(awayScore)", AppColors.red, AppColors.red)
            
        case .finished:
            if homeScore > awayScore {
                return ("\(homeScore)", "\(awayScore)", AppColors.primaryLabel, AppColors.secondaryLabel)
            } else if awayScore > homeScore {
                return ("\(homeScore)", "\(awayScore)", AppColors.secondaryLabel, AppColors.primaryLabel)
            } else {
                return ("\(homeScore)", "\(awayScore)", AppColors.primaryLabel, AppColors.primaryLabel)
            }
            
        default:
            return (AppStrings.empty, AppStrings.empty, AppColors.primaryLabel, AppColors.primaryLabel)
        }
    }

    private static func logoImage(for teamName: String) -> UIImage? {
        switch teamName {
        case AppStrings.realMadrid: return UIImage(named: "realmadrid")
        case AppStrings.barcelona:  return UIImage(named: "barcelona")
        case AppStrings.villareal:  return UIImage(named: "villareal")
        case AppStrings.mallorca:   return UIImage(named: "mallorca")
        case AppStrings.newcastle:   return UIImage(named: "newcastle")
        case AppStrings.manUtd:   return UIImage(named: "manUtd")
        case AppStrings.manCity:   return UIImage(named: "manCity")
        case AppStrings.liverpool:   return UIImage(named: "liverpool")
        case AppStrings.arsenal:   return UIImage(named: "arsenal")
        case AppStrings.chelsea:   return UIImage(named: "chelsea")
        default: return nil
        }
    }

    private static func liveMatchMinuteText(from timestamp: Int) -> String {
        let startDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let minutes = Int(Date().timeIntervalSince(startDate) / 60)
        return "\(max(1, minutes))'"
    }

    private static func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = AppStrings.timeFormat
        return formatter.string(from: date)
    }
}
