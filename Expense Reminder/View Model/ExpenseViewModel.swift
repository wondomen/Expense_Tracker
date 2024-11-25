import Foundation
import Combine
import UserNotifications

class ExpenseViewModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Published Properties
    @Published var expenses: [Expense] = []
    @Published var budget: Budget = Budget(monthlyLimit: 1000.0) // Default budget
    @Published var totalSpent: Double = 0.0
    @Published var remainingBudget: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private var highestThresholdReached: Double = 0.0
    
    // MARK: - Initialization
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        requestNotificationPermissions()
        loadExpenses()
        loadBudget()
        calculateTotals()

        // Recalculate totals when expenses or budget change
        $expenses
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.calculateTotals()
                self?.saveExpenses()
            }
            .store(in: &cancellables)

        $budget
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.calculateTotals()
                self?.saveBudget()
            }
            .store(in: &cancellables)
    }

    // MARK: - Expense Management
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    // MARK: - Budget Calculations
    func calculateTotals() {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())

        // Filter expenses for the current month and year
        let monthlyExpenses = expenses.filter {
            let expenseMonth = calendar.component(.month, from: $0.date)
            let expenseYear = calendar.component(.year, from: $0.date)
            return expenseMonth == currentMonth && expenseYear == currentYear
        }

        // Calculate total spent
        totalSpent = monthlyExpenses.reduce(0) { $0 + $1.amount }
        remainingBudget = budget.monthlyLimit - totalSpent

        // Check budget thresholds for alerts
        checkBudgetThresholds()
    }

    // MARK: - Notification Permissions
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permissions granted.")
            } else {
                print("Notification permissions denied.")
            }
        }
    }

    // MARK: - Budget Alerts
    func checkBudgetThresholds() {
        let thresholds: [Double] = [1.0, 0.9, 0.75] // 100%, 90%, 75%
        for threshold in thresholds {
            if totalSpent >= budget.monthlyLimit * threshold && highestThresholdReached < threshold {
                highestThresholdReached = threshold
                scheduleBudgetAlert(percent: Int(threshold * 100))
                break
            }
        }
    }

    func scheduleBudgetAlert(percent: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Budget Alert"
        content.body = "You've reached \(percent)% of your monthly budget."
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // Immediate delivery
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Budget alert notification scheduled.")
            }
        }
    }

    // MARK: - Data Persistence
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    private func expensesFileURL() -> URL {
        getDocumentsDirectory().appendingPathComponent("expenses.json")
    }

    private func budgetFileURL() -> URL {
        getDocumentsDirectory().appendingPathComponent("budget.json")
    }

    func saveExpenses() {
        do {
            let data = try JSONEncoder().encode(expenses)
            try data.write(to: expensesFileURL())
        } catch {
            print("Failed to save expenses: \(error.localizedDescription)")
        }
    }

    func loadExpenses() {
        let url = expensesFileURL()
        if let data = try? Data(contentsOf: url),
           let decodedExpenses = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decodedExpenses
        }
    }

    func saveBudget() {
        do {
            let data = try JSONEncoder().encode(budget)
            try data.write(to: budgetFileURL())
        } catch {
            print("Failed to save budget: \(error.localizedDescription)")
        }
    }

    func loadBudget() {
        let url = budgetFileURL()
        if let data = try? Data(contentsOf: url),
           let decodedBudget = try? JSONDecoder().decode(Budget.self, from: data) {
            budget = decodedBudget
        }
    }

    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification even when the app is in the foreground
        completionHandler([.banner, .sound])
    }
}
