import SwiftUI

struct RMGCoinBg: View {
    @StateObject var user = RMGUser.shared
    var body: some View {
        ZStack {
            Image(.coinsBgRMG)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 42:21, weight: .bold))
                .foregroundStyle(.black)
                .textCase(.uppercase)
                .offset(x: 20)
            
            
            
        }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:70)
        
    }
}

#Preview {
    RMGCoinBg()
}
