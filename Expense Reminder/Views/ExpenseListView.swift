//
//  ExpenseListView.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//


import SwiftUI

struct ExpenseListView: View {
    @StateObject var viewModel = ExpenseViewModel()
    @State private var showingAddExpense = false
    @State private var showingBudgetSettings = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Total Spent: $\(String(format: "%.2f", viewModel.totalSpent))")
                    Spacer()
                    Text("Remaining: $\(String(format: "%.2f", viewModel.remainingBudget))")
                }
                .padding()

                List {
                    ForEach(viewModel.expenses) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.category.rawValue)
                                    .font(.headline)
                                Text(expense.note ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("$\(String(format: "%.2f", expense.amount))")
                        }
                    }
                    .onDelete(perform: viewModel.deleteExpense)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Expenses")
            .navigationBarItems(
                leading:
                    Button(action: {
                        showingBudgetSettings = true
                    }) {
                        Image(systemName: "gearshape")
                    },
                trailing:
                    Button(action: {
                        showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingBudgetSettings) {
                BudgetSettingsView(viewModel: viewModel)
            }
        }
    }
}