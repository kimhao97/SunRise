import Foundation
import UIKit

final class DetailViewModel {
    private var favorite: FavoriteManagedObject?
    private let player = Player.shared
    
    // MARK: - Init
    
    init(track: FavoriteManagedObject) {
        self.favorite = track
    }
    
    // MARK: - Public func
    
    func getTitle() -> String {
        if let track = favorite {
            return track.title ?? "Invalid"
        }
        return "Invalid"
    }
    
    func getUser() -> String {
        if let track = favorite {
            return track.userName ?? "Invalid"
        }
        return "Invalid"
    }
    
    func getSongImaage(completion: @escaping APICompletion<UIImage?>) {
        if let track = favorite {
            track.artworkURL?.downloadImage(completion: completion)
        }
        return completion(.failure(.error("Invalid type")))
    }
    
    // MARK: - CoreData
    
    func saveFavorite() {
        if let track = favorite {
            player.saveFavorite(id: Int(track.id))
        }
    }
    
    func removeFavorite() {
        if let track = favorite {
            player.removeFavorite(id: Int(track.id))
        }
        
    }
    
    func isLiked() -> Bool {
        if let track = favorite {
            return CoreDataManager.Favorite.findItem(with: Int(track.id))
        }
        return false
    }
}
