import UIKit
import SofaAcademic

struct LeagueViewModel {
    let countryName: String
    let leagueName: String
    let leagueLogo: UIImage?

    init(league: League) {
        self.countryName = league.country?.name ?? "Unknown Country"
        self.leagueName = league.name
        
        switch league.name {
        case "LaLiga":
            self.leagueLogo = UIImage(named: "logo_laliga")
        case "Premier League":
            self.leagueLogo = UIImage(named: "primaryLeague")
        default:
            self.leagueLogo = UIImage(named: "logo_laliga")
        }
    }
}
