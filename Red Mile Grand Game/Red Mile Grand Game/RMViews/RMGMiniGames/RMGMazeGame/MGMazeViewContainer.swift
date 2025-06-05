//
//  MGMazeViewContainer.swift
//  Red Mile Grand Game
//
//  Created by Dias Atudinov on 05.06.2025.
//


import SwiftUI
import SpriteKit


struct MGMazeViewContainer: UIViewRepresentable {
    @StateObject var user = MGUser.shared
    var scene: MGMazeScene
    @Binding var isWin: Bool
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        scene.isWinHandler = {
            isWin = true
            user.updateUserMoney(for: 40)
        }
        skView.presentScene(scene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}
