//
//  DailyEntry.swift
//  gratify
//
//  Created by Daniel Kim on 4/14/24.
//

import Foundation

struct DailyEntry: Encodable {
    let id = UUID()
    var score: Int
    var entry1: String
    var entry2: String
    var entry3: String
    var date: Date
}
