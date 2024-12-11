//
//  CategoryGridView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct CategoryGridView: View {
    @Binding var selectedCategory: ExpenseCategory

    private let categories = ExpenseCategory.allCases
    private let columns = [GridItem(.adaptive(minimum: 80))] // Responsive grid layout

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    print("Selected Category: \(category.rawValue)") // Debugging action
                }) {
                    VStack {
                        Image(systemName: category.iconName)
                            .font(.largeTitle)
                        Text(NSLocalizedString(category.rawValue, comment: "Category name"))
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 80, height: 80)
                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(selectedCategory == category ? .white : .primary)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
