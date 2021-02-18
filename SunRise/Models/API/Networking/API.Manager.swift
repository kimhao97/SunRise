import Foundation

struct APIManager {
    
    enum Path {
        case base_domain, playlists_path, tracks_path, stream_path, user_path, client_path
        
        var localizedDescription: String {
            switch self {
            case .base_domain:
                return "http://api.soundcloud.com"
            case .playlists_path:
                return "/playlists"
            case .tracks_path:
                return"/tracks"
            case .stream_path:
                return "/stream"
            case .user_path:
                return "/users"
            case .client_path:
                return "client_id="
            }
        }
    }
    
    struct Music {}
}
