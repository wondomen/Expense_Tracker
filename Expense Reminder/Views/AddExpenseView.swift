//
//  AddExpenseView.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//


import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var amount = ""
    @State private var category = ExpenseCategory.food
    @State private var date = Date()
    @State private var note = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Category")) {
                    Picker("Select category", selection: $category) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                }

                Section(header: Text("Note")) {
                    TextField("Optional note", text: $note)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveExpense()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(amount.isEmpty)
            )
        }
    }

    func saveExpense() {
        guard let amountValue = Double(amount) else { return }
        let expense = Expense(
            id: UUID(),
            date: date,
            amount: amountValue,
            category: category,
            note: note.isEmpty ? nil : note
        )
        viewModel.addExpense(expense)
    }
}