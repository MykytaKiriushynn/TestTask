//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

class DataManager {
    private let urlString = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
    
    func fetchQuotes(completion: @escaping (Result<[Quote], Error>) -> Void) {
        let url = URL(string: self.urlString)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completion(.success(quotes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func saveFavoriteQuotes(_ quotes: [Quote]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(quotes) {
            UserDefaults.standard.set(encoded, forKey: "favoriteQuotes")
        }
    }

    func loadFavoriteQuotes() -> [Quote] {
        let decoder = JSONDecoder()
        if let savedQuotes = UserDefaults.standard.object(forKey: "favoriteQuotes") as? Data {
            if let decoded = try? decoder.decode([Quote].self, from: savedQuotes) {
                return decoded
            }
        }
        return []
    }
}
