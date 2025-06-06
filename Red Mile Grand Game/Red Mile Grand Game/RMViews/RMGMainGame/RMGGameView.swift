import SwiftUI
import SpriteKit

struct RMGGameView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var gameScene: RMGGameScene = {
        let scene = RMGGameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    @ObservedObject var shopVM: MGShopViewModel
    @State private var powerUse = false
    @State private var isWin = false
    @State private var winner: String? = nil
    @State private var sendPercentage: CGFloat = 1.0
    @State private var score = 0
    @State var level: Int
    var body: some View {
        ZStack {
            MGSpriteViewContainer(scene: gameScene, winner: $winner, sendPercent: $sendPercentage, level: level)
                .ignoresSafeArea()
            
            VStack {
                HStack {
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
                        
                    }.padding([.horizontal, .top])
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                ZStack {
                    
                    VStack(spacing: 12) {
                        
                        Button { sendPercentage = 1.0
                            gameScene.sendPercent = sendPercentage
                        } label: {
                            ZStack {
                                Image(.persentBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:80)
                                
                                Text("Max")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 35:20, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Button { sendPercentage = 0.75
                            gameScene.sendPercent = sendPercentage
                        } label: {
                            ZStack {
                                Image(.persentBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:80)
                                
                                Text("75%")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 35:20, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Button { sendPercentage = 0.5
                            gameScene.sendPercent = sendPercentage
                        } label: {
                            ZStack {
                                Image(.persentBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:80)
                                
                                Text("50%")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 35:20, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Button { sendPercentage = 0.25
                            gameScene.sendPercent = sendPercentage
                        } label: {
                            ZStack {
                                Image(.persentBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:80)
                                
                                Text("25%")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 35:20, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        
                        
                        
                    }
                    
                }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)
            }
            

            
            if let winner = winner {
                if winner == "синяя" {
                    ZStack {
                        Image(.winBgRMG)
                            .resizable()
                            .scaledToFit()
                        
                        VStack() {
                            
                            Spacer()
                            HStack(spacing: 20) {
                                
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                    RMGUser.shared.updateUserMoney(for: 100)
                                } label: {
                                    Image(.homeBtnRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                }
                                
                                Button {
                                    gameScene.restartGame()
                                    self.winner = nil
                                    RMGUser.shared.updateUserMoney(for: 100)
                                } label: {
                                    Image(.backIconRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:80)
                                        .scaleEffect(x: -1, y: 1)
                                }
                                
                                Button {
                                    gameScene.restartGame()
                                    self.winner = nil
                                    RMGUser.shared.updateUserMoney(for: 100)
                                } label: {
                                    Image(.restartBtnRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)

                } else {
                    ZStack {
                        Image(.loseBgRMG)
                            .resizable()
                            .scaledToFit()
                        
                        VStack() {
                            
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
                                    self.winner = nil
                                } label: {
                                    Image(.restartBtnRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)

                }
            }
            
            
        }.background(
            ZStack {
                if let item = shopVM.currentBgItem {
                    Image(item.image)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            }
        )
    }
}

#Preview {
    RMGGameView(shopVM: MGShopViewModel(), level: 0)
}
