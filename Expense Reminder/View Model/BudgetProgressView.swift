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
            Text("Total Spent: $\(totalSpent, specifier: "%.2f")")
            ProgressView(value: progress, total: 1)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .frame(height: 10)
            Text("Remaining Budget: $\(monthlyLimit - totalSpent, specifier: "%.2f")")
        }
        .padding()
    }
}
