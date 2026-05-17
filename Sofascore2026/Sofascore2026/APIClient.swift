import Foundation
import SofaAcademic

final class APIClient {
    
    static let shared = APIClient()
    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    
    private init() {}
    
    func fetchEventsWithCompletion(sportSlug: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let urlString = "\(baseURL)/events?sport=\(sportSlug)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedEvents = try decoder.decode([ApiEvent].self, from: data)
                let domainEvents = decodedEvents.map { $0.toDomain() }
                
                completion(.success(domainEvents))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchEventsAsync(sportSlug: String) async throws -> [Event] {
        let urlString = "\(baseURL)/events?sport=\(sportSlug)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedEvents = try decoder.decode([ApiEvent].self, from: data)
        return decodedEvents.map { $0.toDomain() }
    }
}
