//
//  FavoriteMO+CoreDataProperties.swift
//  SunRise
//
//  Created by Hao Kim on 2/20/21.
//
//

import Foundation
import CoreData


extension FavoriteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMO> {
        return NSFetchRequest<FavoriteMO>(entityName: "Favorite")
    }

    @NSManaged public var artwork_url: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var stream_url: String?
    @NSManaged public var title: String?
    @NSManaged public var user_id: String?
    @NSManaged public var user_name: String?

}

extension FavoriteMO : Identifiable {

}
