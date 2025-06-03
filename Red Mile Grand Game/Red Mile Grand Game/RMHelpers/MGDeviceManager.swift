//
//  MGDeviceManager.swift
//  Red Mile Grand Game
//
//  Created by Dias Atudinov on 04.06.2025.
//


import UIKit

class MGDeviceManager {
    static let shared = MGDeviceManager()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}