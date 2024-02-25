//
//  DadJoke+CoreDataProperties.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//
//

import Foundation
import CoreData


extension DadJoke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DadJoke> {
        return NSFetchRequest<DadJoke>(entityName: "DadJoke")
    }

    @NSManaged public var setup: String?
    @NSManaged public var punchline: String?

}

extension DadJoke : Identifiable {

}
