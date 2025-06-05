//
//  MGShopViewModel.swift
//  Red Mile Grand Game
//
//  Created by Dias Atudinov on 05.06.2025.
//


import SwiftUI


class MGShopViewModel: ObservableObject {
    @Published var shopBgItems: [MGItem] = [
        
        MGItem(name: "bg1", image: "gameRealBg1RMG", icon: "gameBg1RMG", price: 500),
        MGItem(name: "bg2", image: "gameRealBg2RMG", icon: "gameBg2RMG", price: 500),
        MGItem(name: "bg3", image: "gameRealBg3RMG", icon: "gameBg3RMG", price: 500),
        MGItem(name: "bg4", image: "gameRealBg4RMG", icon: "gameBg4RMG", price: 500),
        MGItem(name: "bg5", image: "gameRealBg5RMG", icon: "gameBg5RMG", price: 500),
    ]
    
    @Published var boughtItems: [MGItem] = [
        MGItem(name: "bg1", image: "gameRealBg1RMG", icon: "gameBg1RMG", price: 500),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: MGItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    init() {
        loadCurrentBg()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "backgroundKeyRMG"
    private let userDefaultsBoughtKey = "boughtShopItemsRMG"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(MGItem.self, from: savedData) {
            currentBgItem = loadedItem
        } else {
            currentBgItem = shopBgItems[0]
            print("No saved data found")
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([MGItem].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct MGItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var price: Int
}
