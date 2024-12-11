//
//  AddExpenseView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//


import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    // State variables for picker selection and amount input
    @State private var selectedCategory: ExpenseCategory = .food  // Default category
    @State private var amount: String = ""
    @State private var note: String = ""
    
    var body: some View {
        VStack {
            // Page title
            Text(NSLocalizedString("add_expense_title", comment: "Add New Expense title"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // Category Picker
            Picker(NSLocalizedString("select_category_title", comment: "Select Category label"), selection: $selectedCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    Text(category.rawValue)
                        .tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            // Display the selected category
            Text("\(NSLocalizedString("selected_category_title", comment: "Selected Category label")) \(selectedCategory.rawValue)")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            // Amount Field
            TextField(NSLocalizedString("enter_amount_placeholder", comment: "Enter Amount placeholder"), text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            
            // Note Field (Optional)
            TextField(NSLocalizedString("add_note_placeholder", comment: "Add a Note placeholder"), text: $note)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            
            // Save Button
            Button(action: {
                addExpense()
            }) {
                Text(NSLocalizedString("save_expense_button", comment: "Save Expense button"))
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(NSLocalizedString("add_expense_title", comment: "Add Expense title"), displayMode: .inline)
    }
    
    private func addExpense() {
        guard let amountDouble = Double(amount), amountDouble > 0 else {
            return
        }
        let expense = Expense(id: UUID(), date: Date(), amount: amountDouble, category: selectedCategory, note: note.isEmpty ? nil : note)
        // Add the expense to the view model
        viewModel.addExpense(expense)
        
        // Reset fields after saving the expense
        amount = ""
        note = ""
    }
}
