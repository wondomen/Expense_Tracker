//
//  SettingsView.swift
//  Expense Reminder
//
//  Created by Berhanu Muche on 25.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var notificationsEnabled = true
    @State private var isDarkMode = false
    @State private var showingResetConfirmation = false
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // Toggle Notifications
            Toggle(isOn: $notificationsEnabled) {
                Text("Enable Notifications")
                    .font(.title3)
            }
            .padding()
            .onChange(of: notificationsEnabled) { value in
                if value {
                    viewModel.requestNotificationPermissions()
                } else {
                    print("Notifications Disabled")
                }
            }
            
            // Theme Selection
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
                    .font(.title3)
            }
            .padding()
            .onChange(of: isDarkMode) { value in
                if value {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                } else {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                }
            }
            
            // Reset Expenses Button
            Button(action: {
                showingResetConfirmation = true
            }) {
                Text("Reset Expenses")
                    .font(.title3)
                    .foregroundColor(.red)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
            }
            .padding(.top, 20)
            .alert(isPresented: $showingResetConfirmation) {
                Alert(
                    title: Text("Reset Expenses"),
                    message: Text("Are you sure you want to reset all your expenses?"),
                    primaryButton: .destructive(Text("Reset")) {
                        resetExpenses()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Reset Expenses Functionality
    private func resetExpenses() {
        viewModel.expenses.removeAll()
        viewModel.saveExpenses()
        print("Expenses reset.")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ExpenseViewModel()
        SettingsView(viewModel: viewModel)
    }
}
