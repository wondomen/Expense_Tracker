//
//  Expense.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//


import Foundation
import SwiftUICore

enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    case food = "Food"
    case transportation = "Transportation"
    case entertainment = "Entertainment"
    case utilities = "Utilities"
    case shopping = "Shopping"
    case other = "Other"

    var id: String { self.rawValue }

    // Adding icons and colors for each category
    var iconName: String {
        switch self {
        case .food: return "cart.fill"
        case .transportation: return "car.fill"
        case .entertainment: return "tv.fill"
        case .utilities: return "house.fill"
        case .shopping: return "bag.fill"
        case .other: return "questionmark.circle.fill"
        }
    }
    
    var categoryColor: Color {
        switch self {
        case .food: return .green
        case .transportation: return .blue
        case .entertainment: return .purple
        case .utilities: return .orange
        case .shopping: return .pink
        case .other: return .gray
        }
    }
}

struct Expense: Identifiable, Codable {
    var id: UUID
    var date: Date
    var amount: Double
    var category: ExpenseCategory
    var note: String?
}
