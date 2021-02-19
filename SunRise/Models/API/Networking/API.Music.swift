import Foundation

extension APIManager.Music {
    
    enum QueryString {
        case playlist
        
        var path: String {
            switch self {
            case .playlist:
                return APIManager.APIRouter.playlists_path
                    + "?"
                    + APIManager.APIRouter.client_path
            }
        }
    }
    
    static func getPlaylist(completion: @escaping APICompletion<[Playlist]>) {
        
        let urlString = QueryString.playlist.path
        
        API.shared.request(urlString: urlString) { result -> Void in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data = data {
                    do {
                        let playlists = try JSONDecoder().decode([Playlist].self, from: data)
                        completion(.success(playlists))
                    } catch {
                        completion(.failure(.error(error.localizedDescription)))
                    }
                }
            }
        }
    }
}
