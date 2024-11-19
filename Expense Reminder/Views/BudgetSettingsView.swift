//
//  BudgetSettingsView.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//


import SwiftUI

struct BudgetSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var monthlyLimit = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monthly Budget Limit")) {
                    TextField("Enter budget limit", text: $monthlyLimit)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Budget Settings")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveBudget()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(monthlyLimit.isEmpty)
            )
            .onAppear {
                monthlyLimit = String(format: "%.2f", viewModel.budget.monthlyLimit)
            }
        }
    }

    func saveBudget() {
        guard let budgetValue = Double(monthlyLimit) else { return }
        viewModel.budget.monthlyLimit = budgetValue
    }
}