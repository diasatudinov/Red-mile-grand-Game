import SwiftUI

struct RMGMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    @State private var showCalendar = false
    @State private var showDailyTask = false
    
    @StateObject var achievementVM = RMGAchievementsViewModel()
    @StateObject var settingsVM = SettingsViewModelGE()
    @StateObject var calendarVM = RMGCalendarViewModel()
    @StateObject var shopVM = MGShopViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    RMGCoinBg()
                        
                    Spacer()
                    
                        Button {
                            showSettings = true
                        } label: {
                            Image(.settingsIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:70)
                        }
                    
                    
                }
                
                Spacer()
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        Button {
                            showShop = true
                        } label: {
                            Image(.shopIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                        }
                        
                        
                        HStack {
                            Button {
                                showAchievement = true
                            } label: {
                                Image(.achievementsIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                            }
                            
                            Image(.miniGamesRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                                .opacity(0)
                        }
                    }
                    
                    Spacer()
                    Button {
                        showGame = true
                    } label: {
                        Image(.playIconRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 240:150)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        
                        
                        Button {
                            showCalendar = true
                        } label: {
                            Image(.dailyBonusRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                        }
                        
                        HStack {
                            Button {
                                showMiniGames = true
                            } label: {
                                Image(.miniGamesRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                            }
                            
                            Button {
                                showDailyTask = true
                            } label: {
                                Image(.dailyTaskIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 178:100)
                            }
                        }
                    }
                    
                }
                
               
                
            }.padding()
            
        }
        .background(
            ZStack {
                Image(.appBgRMG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            RMGLevelsMainGameView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
            RMGMiniGameChooseView()
        }
        .fullScreenCover(isPresented: $showAchievement) {
            RMGAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
            MGShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            SettingsView(settingsVM: settingsVM)
        }
        .fullScreenCover(isPresented: $showDailyTask) {
            RMGDailyTaskView()
        }
        .fullScreenCover(isPresented: $showCalendar) {
            RMGCalendarView(viewModel: calendarVM)
        }
        
    }
    
}

#Preview {
    RMGMenuView()
}
