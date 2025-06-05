import SwiftUI

struct MGShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = MGUser.shared
    @ObservedObject var viewModel: MGShopViewModel
    
    @State private var currentIndex = 0
    private let itemsPerPage = 2
    
    var body: some View {
        ZStack {
             
            VStack {
                ZStack {
                    Image(.shopBgRMG)
                        .resizable()
                        .scaledToFit()
                    
                    ZStack {
                        HStack {
                            ForEach(currentItems, id: \.self) { item in
                                shopItem(item: item)
                                
                                
                            }
                        }
                        
                        HStack {
                            Button(action: previousPage) {
                                Image(.arrowRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 150:80)
                                    .scaleEffect(x: -1, y: 1)
                            }
                            .disabled(currentIndex == 0)
                            
                            Spacer()
                            
                            Button(action: nextPage) {
                                Image(.arrowRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 150:80)
                            }
                            .disabled(currentIndex + itemsPerPage >= viewModel.shopBgItems.count)
                        }
                    }.frame(width: MGDeviceManager.shared.deviceType == .pad ? 1000:500)
                    
                    
                }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 600:300)
            }
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        VStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                            } label: {
                                Image(.backIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:50)
                            }
                            
                            MGCoinBg().opacity(0)
                        }
                        
                        Spacer()
                        
                        MGCoinBg()
                        
                    }.padding([.top])
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

    }
    
    @ViewBuilder func shopItem(item: MGItem) -> some View {
        ZStack {
            
            Image(.itemBgRMG)
                .resizable()
                .scaledToFit()
            
            if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                Image(item.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 320:160)
                    .offset(y: MGDeviceManager.shared.deviceType == .pad ? -14:-7)
            } else {
                Image("\(item.icon)Off")
                    .resizable()
                    .scaledToFit()
                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 320:160)
                    .offset(y: MGDeviceManager.shared.deviceType == .pad ? -14:-7)
            }
            VStack {
                Spacer()
                Button {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentBgItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                    
                } label: {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        
                        
                        if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                            Image(.usedBgRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                
                        } else {
                            Image(.useBgRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        }
                        
                        
                    } else {
                        if user.money >= item.price {
                            Image(.buyBtnRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } else {
                            Image(.priceFiveHundredRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        }
                        
                        
                        
                    }
                }
            }
            
            
        }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 400:200)
    }
    
    private var currentItems: [MGItem] {
        let endIndex = min(currentIndex + itemsPerPage, viewModel.shopBgItems.count)
        return Array(viewModel.shopBgItems[currentIndex..<endIndex])
    }
    
    private func nextPage() {
        if currentIndex + itemsPerPage < viewModel.shopBgItems.count {
            currentIndex += itemsPerPage
        }
    }
    
    private func previousPage() {
        if currentIndex >= itemsPerPage {
            currentIndex -= itemsPerPage
        }
    }
    
    
    
}

#Preview {
    MGShopView(viewModel: MGShopViewModel())
}
