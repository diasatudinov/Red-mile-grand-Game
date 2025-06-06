import SwiftUI


class RMGCalendarViewModel: ObservableObject {
    
    @Published var bonuses: [RMGBonus] = [
        RMGBonus(day: 1, amount: 50, isCollected: false),
        RMGBonus(day: 2, amount: 100, isCollected: false),
        RMGBonus(day: 3, amount: 100, isCollected: false),
        RMGBonus(day: 4, amount: 150, isCollected: false),
        RMGBonus(day: 5, amount: 150, isCollected: false),
        RMGBonus(day: 6, amount: 200, isCollected: false),
        RMGBonus(day: 7, amount: 200, isCollected: false),
    
    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsBonusesKey = "userDefaultsBonusesKeyRMG"
    
    func resetBonuses() {
        for index in Range(0...bonuses.count - 1) {
            bonuses[index].isCollected = false
        }
    }
    
    func bonusesToggle(_ bonus: RMGBonus) {
        guard let index = bonuses.firstIndex(where: { $0.id == bonus.id }) else {
            return
        }
        
        bonuses[index].isCollected.toggle()
        
    }
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(bonuses) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBonusesKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBonusesKey),
           let loadedItem = try? JSONDecoder().decode([RMGBonus].self, from: savedData) {
            bonuses = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct RMGBonus: Codable, Hashable {
    var id = UUID()
    var day: Int
    var amount: Int
    var isCollected: Bool
}
