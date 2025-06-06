import SwiftUI

struct RMGLevelsMainGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: RMGShopViewModel

    @State var openGame = false
    @State var selectedIndex = 0
    @State var tutorialPage = 0
    @AppStorage("firstOpen") var firstOpen = true
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Image(.levelsTextRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 180:90)
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
                    }.padding([.horizontal, .top])
                    
                }
                
                
                
                Spacer()
                
                VStack(spacing: 4) {
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 5)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0...9, id: \ .self) { index in
                            ZStack {
                                Image(.levelNumBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:120)
                                
                                Text("\(index + 1)")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 80:40, weight: .semibold))
                                    .foregroundStyle(.red)
                            }
                            .onTapGesture {
                                selectedIndex = index
                                DispatchQueue.main.async {
                                    openGame = true
                                }
                                
                            }
                        }
                    }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 720:610)
                    
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
        .fullScreenCover(isPresented: $openGame) {
             RMGGameView(shopVM: shopVM, level: selectedIndex)
        }
    }

}

#Preview {
    RMGLevelsMainGameView(shopVM: RMGShopViewModel())
}
