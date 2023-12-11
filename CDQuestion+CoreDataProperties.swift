//
//  CDQuestion+CoreDataProperties.swift
//  
//
//  Created by Gleb on 06.11.2023.
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var text: String?
    @NSManaged public var category: String?
    @NSManaged public var premium: Bool

}
