//
//  PersistenceManager.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Person, actionType: PersistenceActionType, completed: @escaping(CBError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInCrew)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
            completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping(Result<[Person], CBError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Person].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToAddToCrew))
        }
    }
    
    static func save(favorites: [Person]) -> CBError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToAddToCrew
        }
    }
}
