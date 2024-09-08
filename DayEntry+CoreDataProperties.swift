//
//  DayEntry+CoreDataProperties.swift
//  gratify
//
//  Created by Kevin Zhou on 4/21/24.
//

import Foundation
import CoreData


extension DayEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayEntry> {
        return NSFetchRequest<DayEntry>(entityName: "DayEntry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var summary1: String?
    @NSManaged public var summary2: String?
    @NSManaged public var summary3: String?

}

extension DayEntry : Identifiable {

}
