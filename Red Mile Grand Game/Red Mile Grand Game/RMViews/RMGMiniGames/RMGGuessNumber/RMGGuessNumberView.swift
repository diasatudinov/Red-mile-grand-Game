import SwiftUI

struct RMGGuessNumberView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = RMGUser.shared
    @State private var target = Int.random(in: 100...999)
    @State private var guessDigits: [String] = []
    @State private var feedback: String = ""
    @State private var attempts = 0
    
    private let padNumbers = [1, 2, 3,
                              4, 5, 6,
                              7, 8, 9,
                              0]
    

        var body: some View {
            ZStack {
                if Int(guessDigits.joined()) ?? 0 != target {
                    VStack(spacing: RMGDeviceManager.shared.deviceType == .pad ? 40:20) {
                        Spacer()
                        
                        ZStack {
                            
                            VStack {
                                
                                ZStack {
                                    
                                    HStack(spacing: 5) {
                                        ForEach(0..<3) { idx in
                                            ZStack {
                                                Image(.numBgRMG)
                                                    .resizable()
                                                    .scaledToFit()
                                                
                                                Text(idx < guessDigits.count ? guessDigits[idx] : "" )
                                                    .font(.system(size: 36, weight: .bold))
                                                    .foregroundColor(.white)
                                            }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 250:150, height: RMGDeviceManager.shared.deviceType == .pad ? 250:150)
                                        }
                                    }
                                    
                                    
                                }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 400:255)
                                
                                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                                HStack(spacing: RMGDeviceManager.shared.deviceType == .pad ? 12:12) {
                                    ForEach(padNumbers, id: \ .self) { num in
                                        Button(action: { numberPressed(num) }) {
                                            ZStack {
                                                Image(.numberBgRMG)
                                                    .resizable()
                                                    .scaledToFit()
                                                Text("\(num)")
                                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 50:36, weight: .bold))
                                                    .foregroundColor(.red)
                                            }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 100:72, height: RMGDeviceManager.shared.deviceType == .pad ? 100:72)
                                        }
                                        .disabled(guessDigits.count >= 3)
                                    }
                                }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 480:200)
                                    .padding(.horizontal)
                            }
                        }.padding()
                        
                        Spacer()
                    }
                }
                
                VStack {
                    ZStack {
                        HStack {
                            Image(.guessNumTextRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
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
                }.padding()
                
                                
                if !feedback.isEmpty {
                    Text(feedback)
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 10)
                        .shadow(radius: 2)
                    
                    ZStack {
                        Color.black.opacity(0.8).ignoresSafeArea()
                        
                        if Int(guessDigits.joined()) ?? 0 < target {
                            ZStack {
                                Image(.incorrectBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                
                                
                                Image(.higherTextRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 30:15)
                                    .offset(y: RMGDeviceManager.shared.deviceType == .pad ? 30:15)
                                
                                
                            }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else if Int(guessDigits.joined()) ?? 0 > target {
                            ZStack {
                                Image(.incorrectBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                
                                
                                Image(.lowerTextRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 30:15)
                                    .offset(y: RMGDeviceManager.shared.deviceType == .pad ? 30:15)
                                
                                
                            }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else {
                            
                            ZStack {
                                Image(.correctBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack(spacing: 20) {
                                        
                                        Button {
                                            presentationMode.wrappedValue.dismiss()
                                        } label: {
                                            Image(.homeBtnRMG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                        }
                                        
                                        Button {
                                            resetGame()
                                            user.updateUserMoney(for: 20)
                                        } label: {
                                            Image(.backIconRMG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:80)
                                                .scaleEffect(x: -1, y: 1)
                                        }
                                        
                                        Button {
                                            resetGame()
                                            user.updateUserMoney(for: 20)
                                        } label: {
                                            Image(.restartBtnRMG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                        }
                                    }
                                }
                                
                                
                            }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 500:250)

                            
                        }
                    }
                    
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

    private func numberPressed(_ num: Int) {
        guard guessDigits.count < 3 else { return }
        guessDigits.append("\(num)")
        if guessDigits.count == 3 {
            evaluateGuess()
        }
    }

    private func evaluateGuess() {
        let guess = Int(guessDigits.joined()) ?? 0
        attempts += 1
        if guess < target {
            feedback = "Too low!"
        } else if guess > target {
            feedback = "Too high!"
        } else {
            feedback = "You got it in \(attempts) tries!"
            RMGUser.shared.updateUserMoney(for: 100)
        }
        if feedback.starts(with: "You got it") {
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // clear digits but keep target and attempts
                guessDigits = []
                feedback = ""
            }
        }
    }

    private func resetGame() {
        target = Int.random(in: 100...999)
        guessDigits = []
        feedback = ""
        attempts = 0
    }
}

#Preview {
    RMGGuessNumberView()
}
