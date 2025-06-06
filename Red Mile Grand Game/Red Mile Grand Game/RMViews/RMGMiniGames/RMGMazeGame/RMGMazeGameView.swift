import SwiftUI
import SpriteKit

struct RMGMazeGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isWin = false
    @State private var gameScene: RMGMazeScene = {
        let scene = RMGMazeScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    @State private var powerUse = false
    
    var body: some View {
        ZStack {
            
            RMGMazeViewContainer(scene: gameScene, isWin: $isWin)
            
            VStack {
                ZStack {
                    
                    HStack(alignment: .top) {
                        Image(.mazeTextRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        
                        Spacer()
                        
                        RMGCoinBg()
                        
                    }.padding([.top])
                    
                }
                
                Spacer()
                HStack {
                    
                    Spacer()
                VStack(spacing: -20) {
                    Spacer()
                    Button {
                        gameScene.moveUp()
                        
                    } label: {
                        Image(.arrowUpRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 130:65)
                    }
                    HStack(spacing: RMGDeviceManager.shared.deviceType == .pad ? 60:30) {
                        Button {
                            gameScene.moveLeft()
                        } label: {
                            Image(.arrowUpRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 130:65)
                                .rotationEffect(.degrees(90))
                                .scaleEffect(x: -1, y: 1)
                        }
                        
                        Button {
                            gameScene.moveRight()
                        } label: {
                            Image(.arrowUpRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 130:65)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    
                    Button {
                        gameScene.moveDown()
                    } label: {
                        Image(.arrowUpRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 130:65)
                            .scaleEffect(x: 1, y: -1)
                    }
                    Spacer()
                }
                }.padding(.horizontal)
                
            }
            
            if isWin {
                ZStack {
                    Image(.correctBgRMG)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 20) {
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.homeBtnRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                            
                            Button {
                                gameScene.restartGame()
                                isWin = false
                            } label: {
                                Image(.backIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:80)
                                    .scaleEffect(x: -1, y: 1)
                            }
                            
                            Button {
                                gameScene.restartGame()
                                isWin = false
                            } label: {
                                Image(.restartBtnRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                        }
                    }
                    
                    
                }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 500:250)

                
            }
            
        }.background(
            ZStack {
                Image(.appBgRMG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    RMGMazeGameView()
}
