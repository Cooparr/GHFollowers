//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import Foundation

class NetworkManager {
    
    //MARK: Properties
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    
    //MARK: Init
    private init() {}
    
    
    //MARK: Get Followers
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?)-> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data recieved from the server was invalid. Please try again.")
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "The data recieved from the server was invalid. Please try again.")
            }
        }
        task.resume()
    }
}
