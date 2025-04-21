//
//  Item.swift
//  expensify
//
//  Created by Anand Rajaram on 21/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
