//
//  BudgetView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct BudgetView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        VStack {
            Text("Set Budget")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            TextField("Enter Monthly Budget", value: $viewModel.budget.monthlyLimit, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}
