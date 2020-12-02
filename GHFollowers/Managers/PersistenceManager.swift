//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    //MARK: Keys Enum
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    //MARK: Properties
    static private let defaults = UserDefaults.standard

    
    //MARK: Update With
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var tempFavoritesArray = favorites
                switch actionType {
                case .add:
                    guard !tempFavoritesArray.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    tempFavoritesArray.append(favorite)
                    
                case .remove:
                    tempFavoritesArray.removeAll {
                        $0.username == favorite.username
                    }
                }
                
                completed(saveFavorites(favorites: tempFavoritesArray))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    //MARK: Retrieve Favorites
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    //MARK: Save Favorites
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
