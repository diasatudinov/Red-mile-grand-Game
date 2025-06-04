import SwiftUI

struct MGDailyTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var task1Done = false
    @State var task2Done = false
    @State var task3Done = false
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.dailyTaskBgRMG)
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 5) {
                    ZStack {
                        HStack {
                            Image(.task1TextRMG)
                                .resizable()
                                .scaledToFit()
                                
                        }
                        HStack {
                            Spacer()
                            if task1Done {
                                Image(.redStickIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 90:50)
                            }
                        }
                    }.frame(width: MGDeviceManager.shared.deviceType == .pad ? 600:350)
                        .onTapGesture {
                            task1Done.toggle()
                        }
                    
                    ZStack {
                        HStack {
                            Image(.task2TextRMG)
                                .resizable()
                                .scaledToFit()
                                
                        }
                        HStack {
                            Spacer()
                            if task2Done {
                                Image(.redStickIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 90:50)
                            }
                        }
                    }.frame(width: MGDeviceManager.shared.deviceType == .pad ? 600:350)
                        .onTapGesture {
                            task2Done.toggle()
                        }
                    
                    ZStack {
                        HStack {
                            Image(.task3TextRMG)
                                .resizable()
                                .scaledToFit()
                                
                        }
                        HStack {
                            Spacer()
                            if task3Done {
                                Image(.redStickIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 90:50)
                            }
                        }
                    }.frame(width: MGDeviceManager.shared.deviceType == .pad ? 600:350)
                        .onTapGesture {
                            task3Done.toggle()
                        }
                    
                }.padding(.top, 20)
                
            }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 600:330)
                        
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
                        
                        
                        MGCoinBg()
                    }.padding(.top)
                }
                
                Spacer()
                
            }
            
        }
        .background(
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
    MGDailyTaskView()
}
