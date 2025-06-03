//
//  MGAchievementsView.swift
//  Red Mile Grand Game
//
//  Created by Dias Atudinov on 04.06.2025.
//


import SwiftUI

struct MGAchievementsView: View {
    @StateObject var user = MGUser.shared
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: MGAchievementsViewModel
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
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 120:70)
                            }
                            
                            MGCoinBg().opacity(0)
                        }
                        Spacer()
                        Image(.achiTextRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 120:60)
                        Spacer()
                        MGCoinBg()
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
                        .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:50)
                
            }
        }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 320:160)
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
    MGAchievementsView(viewModel: MGAchievementsViewModel())
}
