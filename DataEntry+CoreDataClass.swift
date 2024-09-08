//
//  DataEntry+CoreDataClass.swift
//  gratify
//
//  Created by Kevin Zhou on 4/21/24.
//

import Foundation
import CoreData

@objc(DayEntry)
public class DayEntry: NSManagedObject, NSSecureCoding {
    // Required by NSSecureCoding
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    // Required by NSSecureCoding
    public func encode(with coder: NSCoder) {
        coder.encode(date, forKey: "date")
        coder.encode(id, forKey: "id")
        coder.encode(rating, forKey: "rating")
        coder.encode(summary1, forKey: "summary1")
        coder.encode(summary2, forKey: "summary2")
        coder.encode(summary3, forKey: "summary3")
    }
    
    // Required by NSSecureCoding
    public required convenience init?(coder: NSCoder) {
        guard let context = coder.decodeObject(of: NSManagedObjectContext.self, forKey: "managedObjectContext") else {
            return nil
        }
        self.init(context: context)
        
        self.date = coder.decodeObject(of: NSDate.self, forKey: "date") as Date?
        self.id = coder.decodeObject(of: NSUUID.self, forKey: "id") as UUID?
        self.rating = Int16(coder.decodeInteger(forKey: "rating"))
        self.summary1 = coder.decodeObject(of: NSString.self, forKey: "summary1") as String?
        self.summary2 = coder.decodeObject(of: NSString.self, forKey: "summary2") as String?
        self.summary3 = coder.decodeObject(of: NSString.self, forKey: "summary3") as String?
    }
}
