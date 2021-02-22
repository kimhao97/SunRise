import Foundation
import CoreData

@objc(FavoriteManagedObject)
public class FavoriteManagedObject: NSManagedObject {

}

extension FavoriteManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteManagedObject> {
        return NSFetchRequest<FavoriteManagedObject>(entityName: "Favorite")
    }

    @NSManaged public var artwork_url: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var stream_url: String?
    @NSManaged public var title: String?
    @NSManaged public var user_id: String?
    @NSManaged public var user_name: String?

}

extension FavoriteManagedObject : Identifiable {

}
