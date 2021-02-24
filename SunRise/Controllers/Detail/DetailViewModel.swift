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
        return favorite?.title ?? "Invalid"
    }
    
    func getUser() -> String {
        return favorite?.userName ?? "Invalid"
    }
    
    func getSongImage(completion: @escaping APICompletion<UIImage?>) {
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
    
    func addSongToPlaylist() {
//        CoreDataManager.Playlist.save(to: "ABC", with: favorite)
    }
    
    func removeSongFromPlaylist() {
        
//        if let tracks = getTracksFromPlaylist(playlists: playlists, name: "ABC") {
//            for track in tracks {
//                print("Track Title: \(track.title)")
//            }
//        }
        
//        CoreDataManager.Playlist.removeTrackFromPlaylist(trackID: Int(favorite?.id ?? 0) , from: "ABC")
    }
    
//    func getTracksFromPlaylist(playlists: [PlaylistMangedObject], name: String) -> [TrackManagedObject]?{
//        for playlist in playlists where playlist.name == name{
//            return playlist.tracks?.allObjects as? [TrackManagedObject]
//        }
//        return nil
//    }
}
