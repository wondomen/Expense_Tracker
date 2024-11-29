//
//  ExpenseListView.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        VStack {
            Text("Your Expenses")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // Display Expenses List
            if viewModel.expenses.isEmpty {
                Text("No expenses added yet.")
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
                            Text(expense.category.rawValue)
                                .font(.headline)
                            Text("$\(expense.amount, specifier: "%.2f")")
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
        .navigationBarTitle("Expenses", displayMode: .inline)
    }
}
