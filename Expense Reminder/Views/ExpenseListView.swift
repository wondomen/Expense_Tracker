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
        NavigationView {
            VStack {
                // Displaying total spent, remaining budget, and budget limit
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total Spent: $\(viewModel.totalSpent, specifier: "%.2f")")
                        .font(.title2)
                        .padding([.top, .horizontal])
                    Text("Remaining Budget: $\(viewModel.remainingBudget, specifier: "%.2f")")
                        .font(.title2)
                        .padding([.horizontal])
                    Text("Budget Limit: $\(viewModel.budget.monthlyLimit, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding([.horizontal])
                }

                // List of expenses
                List {
                    ForEach(viewModel.expenses) { expense in
                        HStack {
                            Image(systemName: expense.category.iconName)
                                .foregroundColor(expense.category.categoryColor)
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading) {
                                Text(expense.category.rawValue)
                                    .font(.headline)
                                Text(expense.note ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Text("$\(expense.amount, specifier: "%.2f")")
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        .padding([.top, .bottom], 5)
                    }
                    .onDelete(perform: viewModel.deleteExpense)
                }

                // Button to add a new expense
                HStack {
                    Spacer()
                    Button(action: {
                        // Add new expense with default values
                        let newExpense = Expense(id: UUID(), date: Date(), amount: 50.0, category: .food, note: "Lunch")
                        viewModel.addExpense(newExpense)
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Expense")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Expenses")
            .onAppear {
                viewModel.calculateTotals() // Recalculate totals when view appears
            }
        }
    }
}
