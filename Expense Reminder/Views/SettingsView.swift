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
    @State private var selectedLanguage = Locale.current.languageCode ?? "en"

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
            
            // Language Switcher
            VStack(alignment: .leading, spacing: 15) {
                Text("Language")
                    .font(.title3)
                    .padding(.top, 20)
                
                Picker("Select Language", selection: $selectedLanguage) {
                    Text("English").tag("en")
                    Text("Finnish").tag("fi")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedLanguage) { newLanguage in
                    changeLanguage(to: newLanguage)
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
    
    // Function to change the app's language
    private func changeLanguage(to language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        // Prompt user to restart the app
        let alert = UIAlertController(title: "Language Changed", message: "Please restart the app for the changes to take effect.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            exit(0) // Force the app to close, so the language change takes effect
        })
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
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
