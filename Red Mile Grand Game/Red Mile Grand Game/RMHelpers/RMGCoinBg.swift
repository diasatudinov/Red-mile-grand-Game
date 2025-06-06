import SwiftUI

struct RMGCoinBg: View {
    @StateObject var user = MGUser.shared
    var body: some View {
        ZStack {
            Image(.coinsBgRMG)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: MGDeviceManager.shared.deviceType == .pad ? 42:21, weight: .bold))
                .foregroundStyle(.black)
                .textCase(.uppercase)
                .offset(x: 20)
            
            
            
        }.frame(height: MGDeviceManager.shared.deviceType == .pad ? 120:70)
        
    }
}

#Preview {
    RMGCoinBg()
}
