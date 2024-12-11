//
//  HomePageView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Page title
                Text(NSLocalizedString("welcome_title", comment: "Title for the home page"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                // Expense Overview
                VStack(alignment: .leading, spacing: 15) {
                    Text(String(format: NSLocalizedString("total_spent", comment: "Total spent label"), viewModel.totalSpent))
                        .font(.title3)
                    Text(String(format: NSLocalizedString("remaining_budget", comment: "Remaining budget label"), viewModel.remainingBudget))
                        .font(.title3)
                    Text(String(format: NSLocalizedString("budget_limit", comment: "Budget limit label"), viewModel.budget.monthlyLimit))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)
                }
                .padding()

                // Navigation buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: ExpenseListView(viewModel: viewModel)) {
                        HomePageButton(title: NSLocalizedString("view_expenses", comment: "Button to view expenses"), imageName: "list.dash")
                    }
                    
                    NavigationLink(destination: BudgetView(viewModel: viewModel)) {
                        HomePageButton(title: NSLocalizedString("set_budget", comment: "Button to set budget"), imageName: "creditcard")
                    }

                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        HomePageButton(title: NSLocalizedString("settings", comment: "Button to navigate to settings"), imageName: "gearshape.fill")
                    }
                    
                    // "Add Expense" button added here
                    NavigationLink(destination: AddExpenseView(viewModel: viewModel)) {
                        HomePageButton(title: NSLocalizedString("add_expense", comment: "Button to add an expense"), imageName: "plus.circle.fill")
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true) // Hide the navigation bar on the homepage
        }
    }
}

// Custom Button for the Homepage
struct HomePageButton: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.blue))
            
            Text(title)
                .font(.title2)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 5)
    }
}

// Preview for SwiftUI
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ExpenseViewModel()
        HomePageView(viewModel: viewModel)
    }
}
