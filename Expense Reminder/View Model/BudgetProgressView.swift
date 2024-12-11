//
//  BudgetProgressView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct BudgetProgressView: View {
    var totalSpent: Double
    var monthlyLimit: Double
    
    var progress: CGFloat {
        return CGFloat(totalSpent / monthlyLimit)
    }
    
    var body: some View {
        VStack {
            // Using NSLocalizedString to fetch localized string for "Total Spent"
            Text(String(format: NSLocalizedString("total_spent", comment: "Total Spent label"), totalSpent))
            
            ProgressView(value: progress, total: 1)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .frame(height: 10)
            
            // Using NSLocalizedString to fetch localized string for "Remaining Budget"
            Text(String(format: NSLocalizedString("remaining_budget", comment: "Remaining Budget label"), monthlyLimit - totalSpent))
        }
        .padding()
    }
}
