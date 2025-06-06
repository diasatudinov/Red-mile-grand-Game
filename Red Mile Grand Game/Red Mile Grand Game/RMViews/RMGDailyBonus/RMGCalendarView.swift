import SwiftUI

struct RMGCalendarView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = RMGUser.shared
    @ObservedObject var viewModel: CalendarViewModel
    @State private var timer: Timer?
    
    @State private var bonusAmount = 0
    let defaults = UserDefaults.standard
    var bonuses: [Bonus] {
        return viewModel.bonuses
    }
    @AppStorage("openedBonuses") var openBonus = 1
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
          
                ZStack {
                    Image(.dailyTaskBgRMG)
                        .resizable()
                        .scaledToFit()
                    HStack {
                        LazyVGrid(columns: columns, spacing: RMGDeviceManager.shared.deviceType == .pad ? 0:0) {
                            ForEach(viewModel.bonuses, id: \.self) { bonus in
                                VStack(spacing: 0) {
                                        
                                        ZStack {
                                            
                                            Image(bonus.isCollected ? .openedBoxBgRMG:.closedBoxBgRMG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: RMGDeviceManager.shared.deviceType == .pad ? 170:95,height: RMGDeviceManager.shared.deviceType == .pad ? 170:95)
                                            
                                            Text("\(bonus.day)")
                                                .font(.system(size: 30, weight: .black))
                                                .foregroundStyle(.red)
                                                .offset(y: -7)
                                            
                                            if bonus.isCollected {
                                                VStack {
                                                    HStack {
                                                        
                                                        Image(.redStickIconRMG)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 80:40)
                                                            .offset(x: RMGDeviceManager.shared.deviceType == .pad ? 20:10, y: RMGDeviceManager.shared.deviceType == .pad ? 20:10)
                                                    }
                                                }.offset(x: -7, y: -7)
                                            } else {
                                                if openBonus >= bonus.day {
                                                    if !bonus.isCollected {
                                                        VStack {
                                                            Spacer()
                                                            Button {
                                                                bonusAmount = bonus.amount
                                                                withAnimation {
                                                                    viewModel.bonusesToggle(bonus)
                                                                }
                                                                
                                                                user.updateUserMoney(for: bonus.amount)
                                                                
                                                            } label: {
                                                                Image(.getBtnRMG)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 80:40)
                                                            }
                                                        }
                                                        
                                                    }
                                                    
                                                    
                                                } else {
                                                    Image(.lockIconRMG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                                                }
                                            }
                                            
                                        }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 200:100,height: RMGDeviceManager.shared.deviceType == .pad ? 200:100)
                                }.offset(x: bonus.day > 4 ? 50:0)
                                
                                
                            }
                        }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 800:400)
                        
                        
                    }.padding(.top, RMGDeviceManager.shared.deviceType == .pad ? 96:48)
                }
                
            
            
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 150:75)
                        }
                        Spacer()
                        RMGCoinBg()
                    }.padding([.horizontal, .top])
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
        .onAppear {
            startRepeatingCheck()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func recordLastOpenTimeIfNeeded() {
        // If never opened before, set now
        if defaults.object(forKey: "lastOpenTime") == nil {
            defaults.set(Date(), forKey: "lastOpenTime")
        }
    }
    
    func has24HoursPassed() -> Bool {
        if let lastOpen = defaults.object(forKey: "lastOpenTime") as? Date {
            let now = Date()
            let interval = now.timeIntervalSince(lastOpen)
            return interval >= 86400 // 24 hours in seconds
        }
        return true
    }
    
    func check24HourStatus() {
        if has24HoursPassed() {
            if openBonus < 7 {
                openBonus += 1
            } else {
                openBonus = 1
                viewModel.resetBonuses()
            }
            
            defaults.set(Date(), forKey: "lastOpenTime")
        }
    }
    
    func startRepeatingCheck() {
        recordLastOpenTimeIfNeeded()
        
        check24HourStatus()
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.check24HourStatus()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview {
    RMGCalendarView(viewModel: CalendarViewModel())
}
