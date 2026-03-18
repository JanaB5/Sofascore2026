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
        homeTeamName = event.homeTeam.name
        awayTeamName = event.awayTeam.name

        homeTeamLogo = EventViewModel.logoImage(for: event.homeTeam.name)
        awayTeamLogo = EventViewModel.logoImage(for: event.awayTeam.name)

        timeText = EventViewModel.formatTime(from: event.startTimestamp)

        switch event.status {
        case .notStarted:
            statusText = AppStrings.dash
            statusColor = AppColors.secondaryLabel

            homeScoreText = AppStrings.empty
            awayScoreText = AppStrings.empty
            homeScoreColor = AppColors.primaryLabel
            awayScoreColor = AppColors.primaryLabel

        case .inProgress:
            statusText = EventViewModel.liveMatchMinuteText(from: event.startTimestamp)
            statusColor = AppColors.red

            homeScoreText = "\(event.homeScore ?? 0)"
            awayScoreText = "\(event.awayScore ?? 0)"
            homeScoreColor = AppColors.red
            awayScoreColor = AppColors.red

        case .finished:
            statusText = AppStrings.fullTime
            statusColor = AppColors.secondaryLabel
            
            let homeScore = event.homeScore ?? 0
            let awayScore = event.awayScore ?? 0

            homeScoreText = "\(homeScore)"
            awayScoreText = "\(awayScore)"

            if homeScore > awayScore {
                homeScoreColor = AppColors.primaryLabel
                awayScoreColor = AppColors.secondaryLabel
            } else if awayScore > homeScore {
                homeScoreColor = AppColors.secondaryLabel
                awayScoreColor = AppColors.primaryLabel
            } else {
                homeScoreColor = AppColors.primaryLabel
                awayScoreColor = AppColors.primaryLabel
            }

        default:
            statusText = AppStrings.dash
            statusColor = AppColors.secondaryLabel

            homeScoreText = AppStrings.empty
            awayScoreText = AppStrings.empty
            homeScoreColor = AppColors.primaryLabel
            awayScoreColor = AppColors.primaryLabel
        }
    }

    private static func logoImage(for teamName: String) -> UIImage? {
        switch teamName {
        case AppStrings.realMadrid:
            return UIImage(named: "realmadrid")
        case AppStrings.barcelona:
            return UIImage(named: "barcelona")
        case AppStrings.villareal:
            return UIImage(named: "villareal")
        case AppStrings.mallorca:
            return UIImage(named: "mallorca")
        default:
            return nil
        }
    }

    private static func liveMatchMinuteText(from timestamp: Int) -> String {
        let startDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let currentDate = Date()

        let minutes = Int(currentDate.timeIntervalSince(startDate) / 60)
        let safeMinutes = max(1, minutes)

        return "\(safeMinutes)'"
    }

    private static func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = AppStrings.timeFormat
        return formatter.string(from: date)
    }
}
