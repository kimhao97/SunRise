import Foundation
import UIKit
import CoreData

extension CoreDataManager.Playing {

    static func save(with track: Track) {
        if let managedContext = CoreDataManager.appDelegate?.persistentContainer.viewContext {
            let playingMO = PlayingMO(context: managedContext)
            
            playingMO.id = Int32(track.trackID ?? 0)
            playingMO.title = track.title
            playingMO.genre = track.genre
            playingMO.artwork_url = track.artworkURL
            playingMO.stream_url = track.streamURL
            playingMO.user_name = track.userName
        
            do {
                try managedContext.save()
            } catch let error as NSError {
               print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    static func fetchData() -> [PlayingMO]? {
        if let managedContext = CoreDataManager.appDelegate?.persistentContainer.viewContext {
            let request: NSFetchRequest<PlayingMO> = PlayingMO.fetchRequest()
            request.returnsObjectsAsFaults = false
            
            do {
                let result = try managedContext.fetch(request)
                for data in result {
                    print(data.title!)
                }
                return result
            } catch {
                print("Fetch request failed")
                return nil
            }
        }
        return nil
    }
    
    static func deleteAllObject() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let savedItems = fetchData() {
            for savedItem in savedItems {
                managedContext.performAndWait {
                    managedContext.delete(savedItem)
                }
            }
        }
    }
}
