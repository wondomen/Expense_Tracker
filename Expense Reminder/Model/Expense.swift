//
//  Expense.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//


import Foundation

struct Expense: Identifiable, Codable {
    let id: UUID
    let date: Date
    let amount: Double
    let category: ExpenseCategory
    let note: String?
}

enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    case food = "Food"
    case transportation = "Transportation"
    case entertainment = "Entertainment"
    case utilities = "Utilities"
    case shopping = "Shopping"
    case other = "Other"

    var id: String { self.rawValue }
}