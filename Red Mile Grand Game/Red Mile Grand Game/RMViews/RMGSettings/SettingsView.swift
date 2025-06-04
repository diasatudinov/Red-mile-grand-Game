import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: SettingsViewModelGE
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.settingsViewBgRMG)
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 30) {
                    HStack {
                        Image(.soundIconRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 160:80)
                        VStack {
                            Image(.soundTextRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 20:10)
                            Button {
                                withAnimation {
                                    settingsVM.soundEnabled.toggle()
                                }
                            } label: {
                                
                                Image(settingsVM.soundEnabled ? .onIconRMG:.offIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 80:40)
                            }
                        }
                    }
                    
                    HStack {
                        Image(.musicIconRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 160:80)
                        VStack {
                            Image(.musicTextRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 20:10)
                            Button {
                                withAnimation {
                                    settingsVM.musicEnabled.toggle()
                                }
                            } label: {
                                
                                Image(settingsVM.musicEnabled ? .onIconRMG:.offIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 80:40)
                            }
                        }
                    }
                }
            }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 650:350)
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MGDeviceManager.shared.deviceType == .pad ? 150:75)
                        }
                        Spacer()
                       
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
    }
}

#Preview {
    SettingsView(settingsVM: SettingsViewModelGE())
}
