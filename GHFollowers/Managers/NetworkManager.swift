//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 12/07/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completed(nil, "This username doesn't work")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "error")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Error")
                return
            }
            
            guard let data = data else {
                completed(nil, "Error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "Error")
            }
        }
        
        task.resume()
    }
}
