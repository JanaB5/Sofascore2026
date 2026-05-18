import UIKit
import SofaAcademic

struct EventNavigationBarViewModel {
    let navBarText: String
    let leagueLogo: UIImage?
    
    init(event: Event, league: League, sportSlug: String) {
        let leagueVM = LeagueViewModel(league: league)
        
        let sportName = sportSlug.capitalized
        let countryName = leagueVM.countryName ?? ""
        let leagueName = leagueVM.leagueName ?? ""
        
        self.navBarText = [sportName, countryName, leagueName]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
        
        self.leagueLogo = leagueVM.leagueLogo
    }
}
