//
//  Items+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Aruna Lakmal2 on 9/25/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var details: String?
    @NSManaged public var image: NSData?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var price: Double

}
