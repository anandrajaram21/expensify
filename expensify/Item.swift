//
//  Item.swift
//  expensify
//
//  Created by Anand Rajaram on 21/04/25.
//

import Foundation
import SwiftData

@Model
final class Person {
    var name: String
    @Relationship(deleteRule: .cascade) var expenses: [Expense] = []
    
    init(name: String) {
        self.name = name
    }
    
    var total: Double {
        expenses.filter { !$0.isPaid }.reduce(0) { $0 + $1.amount }
    }
}

@Model
final class Expense {
    var expenseDescription: String
    var amount: Double
    var date: Date
    var isPaid: Bool
    
    init(expenseDescription: String, amount: Double, date: Date = Date(), isPaid: Bool = false) {
        self.expenseDescription = expenseDescription
        self.amount = amount
        self.date = date
        self.isPaid = isPaid
    }
}
