import Foundation
import SofaAcademic

struct ApiCountry: Codable {
    let id: Int?
    let name: String
}

struct ApiTeam: Codable {
    let id: Int
    let name: String
    let logoUrl: String?
}

struct ApiLeague: Codable {
    let id: Int
    let name: String
    let country: ApiCountry?
    let logoUrl: String?
}

struct ApiEvent: Codable {
    let id: Int
    let homeTeam: ApiTeam
    let awayTeam: ApiTeam
    let league: ApiLeague?
    let status: String
    let startTimestamp: Int
    let homeScore: Int?
    let awayScore: Int?
    
    func toDomain() -> Event {
        let countryDomain = Country(
            id: league?.country?.id ?? 0,
            name: league?.country?.name ?? "Unknown"
        )
        
        let leagueDomain = League(
            id: league?.id ?? 0,
            name: league?.name ?? "Unknown",
            country: countryDomain,
            logoUrl: league?.logoUrl ?? ""
        )
        
        let homeDomain = Team(
            id: homeTeam.id,
            name: homeTeam.name,
            logoUrl: homeTeam.logoUrl ?? ""
        )
        
        let awayDomain = Team(
            id: awayTeam.id,
            name: awayTeam.name,
            logoUrl: awayTeam.logoUrl ?? ""
        )
        
        var eventStatus: EventStatus = .notStarted
        if status == "in_progress" { eventStatus = .inProgress }
        else if status == "finished" { eventStatus = .finished }
        
        return Event(
            id: id,
            homeTeam: homeDomain,
            awayTeam: awayDomain,
            league: leagueDomain,
            status: eventStatus,
            startTimestamp: startTimestamp,
            homeScore: homeScore,
            awayScore: awayScore
        )
    }
}
