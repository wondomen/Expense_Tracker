//
//  ExpenseListView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("your_expenses", comment: "Title for the expense list"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // Display Expenses List
            if viewModel.expenses.isEmpty {
                Text(NSLocalizedString("no_expenses", comment: "Message when no expenses are added"))
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.expenses) { expense in
                    HStack {
                        // Category Icon
                        Image(systemName: expense.category.iconName)
                            .foregroundColor(expense.category.categoryColor)
                            .padding(.trailing, 10)
                        
                        // Expense Details
                        VStack(alignment: .leading) {
                            Text(NSLocalizedString(expense.category.rawValue, comment: "Category name"))
                                .font(.headline)
                            Text(String(format: NSLocalizedString("expense_amount", comment: "Amount of the expense"), expense.amount))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            if let note = expense.note {
                                Text(note)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(NSLocalizedString("expenses", comment: "Navigation bar title"), displayMode: .inline)
    }
}
