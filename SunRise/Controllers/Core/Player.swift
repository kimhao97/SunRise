import Foundation
import AVFoundation

enum State {
    case isPlaying
    case stopped
}

final class Player {
    
    static let shared = Player()
    private var audioPlayer = AVPlayer()
    
    var state: State = .stopped {
        didSet {
            switch state {
            case .stopped:
                audioPlayer.pause()
            case .isPlaying:
                audioPlayer.volume = 1.0
                audioPlayer.play()
            }
        }
    }
    
    private init() {}
    
    // MARK: - Play music
    
    func addSongPlayer(streamUrl: String?, completion: (Bool) -> Void) {
        if let streamUrl = streamUrl {
            let urlString = streamUrl + "?" + APIManager.APIRouter.client_path
            guard let url = URL(string: urlString) else {
                completion(false)
                return
            }
            audioPlayer = AVPlayer(url: url)
            completion(true)
        }
    }
    
    func playMusic(with track: Track) {
        addSongPlayer(streamUrl: track.streamURL) { done in
            if done {
                state = .isPlaying
                saveSongPlaying(with: track)
                
                NotificationCenter.default.addObserver(self,
                                                selector: #selector(playerDidReachEnd),
                                                name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                                object: nil)
            }
        }
    }
    
//        private func autoPlayMusic() -> String? {
//            if let streamString = songs.randomElement()?.value.randomElement()?.streamURL {
//                playMusic(with: )
//                return streamString
//            }
//
//            return nil
//        }
    
    @objc func playerDidReachEnd() {
        state = .stopped
        
//        autoPlayMusic()
    }
    
    private func streamUrlPlaying() -> String? {
        if let url = ((audioPlayer.currentItem?.asset) as? AVURLAsset)?.url {

            let urlString = String(describing: url)

            let endOfSentence = urlString.firstIndex(of: "?") ?? urlString.endIndex
            let streamString = urlString[..<endOfSentence]
            print("Current url: \(streamString)")
            return String(describing: streamString)
        }

        return nil
    }
    
    // MARK: - CoreData
    
    func fetchTrackPlaying() -> PlayingMO?{
        if let playing = CoreDataManager.Playing.fetchData()?.first {
            
            if streamUrlPlaying() == nil {
                addSongPlayer(streamUrl: playing.stream_url,
                              completion: { _ in })
            }

            return playing
        }
        return nil
    }
    
    func saveSongPlaying(with track: Track) {
        CoreDataManager.Playing.deleteAllObject()
        CoreDataManager.Playing.save(with: track)
    }
    
}
