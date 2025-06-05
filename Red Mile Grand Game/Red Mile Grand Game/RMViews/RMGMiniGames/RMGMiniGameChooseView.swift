import SwiftUI

struct RMGMiniGameChooseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var game1 = false
    @State private var game2 = false
    @State private var game3 = false
    @State private var game4 = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                        
                        MGCoinBg()
                    }.padding([.horizontal, .top])
                    
                }
                
                Spacer()
                
                
                    
                HStack(alignment: .top, spacing: 16) {
                        Button {
                            game1 = true
                        } label: {
                            Image(.game1IconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 300:180)
                            
                        }
                        
                        Button {
                            game2 = true
                        } label: {
                            Image(.game2IconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 300:180)
                            
                        }
                        Button {
                            game3 = true
                        } label: {
                            Image(.game3IconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 300:180)
                            
                        }
                        
                        Button {
                            game4 = true
                        } label: {
                            Image(.game4IconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 300:180)
                            
                        }
                    }
                
                
                Spacer()
                
            }
        }.background(
            ZStack {
                Image(.appBgRMG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $game1) {
            MGMatchTheCardView()
        }
        .fullScreenCover(isPresented: $game2) {
            MGGuessNumberView()
        }
        .fullScreenCover(isPresented: $game3) {
            MGFindSequenceView()
        }
        .fullScreenCover(isPresented: $game4) {
            MGMazeGameView()
            
        }
    }
}
#Preview {
    RMGMiniGameChooseView()
}
