import Foundation
import CoreData

@objc(PlayingManagedObject)
public class PlayingManagedObject: NSManagedObject {

}

extension PlayingManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayingManagedObject> {
        return NSFetchRequest<PlayingManagedObject>(entityName: "Playing")
    }

    @NSManaged public var artwork_url: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var stream_url: String?
    @NSManaged public var title: String?
    @NSManaged public var user_id: String?
    @NSManaged public var user_name: String?

}

extension PlayingManagedObject : Identifiable {

}
