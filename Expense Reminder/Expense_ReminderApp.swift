//
//  Expense_ReminderApp.swift
//  Expense Reminder
//
//  Created by Amir Ghari on 11/19/24.
//

import SwiftUI

@main
struct Expense_ReminderApp: App {
    // Initialize the ViewModel
    @StateObject private var viewModel = ExpenseViewModel()

    var body: some Scene {
        WindowGroup {
            HomePageView(viewModel: viewModel)
        }
    }
}

