//
//  BudgetSettingsView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//
import SwiftUI

struct BudgetSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var monthlyLimit = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(NSLocalizedString("monthly_budget_limit", comment: "Monthly Budget Limit header"))) {
                    TextField(NSLocalizedString("enter_budget_limit_placeholder", comment: "Enter Budget Limit placeholder"), text: $monthlyLimit)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(NSLocalizedString("budget_settings_title", comment: "Budget Settings title"))
            .navigationBarItems(
                leading: Button(NSLocalizedString("cancel_button", comment: "Cancel button")) {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(NSLocalizedString("save_button", comment: "Save button")) {
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
