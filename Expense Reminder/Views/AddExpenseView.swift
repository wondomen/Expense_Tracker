
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
            Text("Add New Expense")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // Category Picker
            Picker("Select Category", selection: $selectedCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    Text(category.rawValue)
                        .tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())  // You can change this style if you prefer
            .padding()
            
            // Display the selected category
            Text("Selected Category: \(selectedCategory.rawValue)")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            // Amount Field
            TextField("Enter Amount", text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            
            // Note Field (Optional)
            TextField("Add a Note (Optional)", text: $note)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            
            // Save Button
            Button(action: {
                addExpense()
            }) {
                Text("Save Expense")
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
        .navigationBarTitle("Add Expense", displayMode: .inline)
    }
    
    private func addExpense() {
        // Make sure the amount is a valid number
        guard let amountDouble = Double(amount), amountDouble > 0 else {
            // Handle invalid input
            return
        }
        
        // Create a new expense
        let expense = Expense(id: UUID(), date: Date(), amount: amountDouble, category: selectedCategory, note: note.isEmpty ? nil : note)
        
        // Add the expense to the view model
        viewModel.addExpense(expense)
        
        // Reset fields after saving the expense
        amount = ""
        note = ""
    }
}

