import SwiftUI

struct RMGAchievementsView: View {
    @StateObject var user = RMGUser.shared
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: RMGAchievementsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                            } label: {
                                Image(.backIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:70)
                            }
                            
                            RMGCoinBg().opacity(0)
                        }
                        Spacer()
                        Image(.achiTextRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                        Spacer()
                        RMGCoinBg()
                    }.padding([.top])
                }
                
                
                HStack {
                    ForEach(viewModel.achievements, id: \.self) { achieve in
                        achievementItem(item: achieve)
                            .onTapGesture {
                                viewModel.achieveToggle(achieve)
                            }
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
    }
    
    @ViewBuilder func achievementItem(item: MGAchievement) -> some View {
        
        ZStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                
            
            VStack(spacing: 0) {
                
                Spacer()
                
                    Image(.stickIconRMG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                
            }
        }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 320:160)
            .opacity(item.isAchieved ? 1:0.5)
            .offset(y: offsetConfig(item: item))
    }
    
    private func offsetConfig(item: MGAchievement) -> CGFloat {
        switch item.image {
        case "achieve1ImageRMG":
            return -40
        case "achieve2ImageRMG":
            return 40
        case "achieve3ImageRMG":
            return -50
        case "achieve4ImageRMG":
            return 40
        case "achieve5ImageRMG":
            return -40
        default:
            return 0
        }
        
    }
    
}


#Preview {
    RMGAchievementsView(viewModel: RMGAchievementsViewModel())
}
