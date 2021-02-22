import Foundation
import CoreData


extension PlayingMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayingMO> {
        return NSFetchRequest<PlayingMO>(entityName: "Playing")
    }

    @NSManaged public var artwork_url: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var stream_url: String?
    @NSManaged public var title: String?
    @NSManaged public var user_id: String?
    @NSManaged public var user_name: String?

}

extension PlayingMO : Identifiable {

}
