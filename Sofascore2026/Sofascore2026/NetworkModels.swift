import Foundation
import SofaAcademic

struct Country: Codable {
    let id: Int?
    let name: String
}

struct Team: Codable {
    let id: Int
    let name: String
    let logoUrl: String?
}

struct League: Codable {
    let id: Int
    let name: String
    let country: Country?
    let logoUrl: String?
}

struct Event: Codable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let league: League?
    private let status: String
    let startTimestamp: Int
    let homeScore: Int?
    let awayScore: Int?
    
    var eventStatus: EventStatus {
        let lowerStatus = status.lowercased()
        if lowerStatus == "in_progress" || lowerStatus == "inprogress" || lowerStatus == "live" {
            return .inProgress
        } else if lowerStatus == "finished" || lowerStatus == "ended" || lowerStatus == "ft" {
            return .finished
        }
        return .notStarted
    }

    enum CodingKeys: String, CodingKey {
        case id, homeTeam, awayTeam, league, status, startTimestamp, homeScore, awayScore
    }
}
