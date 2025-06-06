import SwiftUI

struct RMGFindSequenceView: View {
    @StateObject var user = RMGUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    let cardImages = [
        "sequenceCardFace1RMG",
        "sequenceCardFace2RMG",
        "sequenceCardFace3RMG",
        "sequenceCardFace4RMG",
        "sequenceCardFace5RMG",
        "sequenceCardFace6RMG",
        "sequenceCardFace7RMG",
        "sequenceCardFace8RMG"
    ]
    let sequenceLength = 3
    
    @State private var sequence: [Int] = []
    @State private var currentStep: Int? = nil
    @State private var gamePhase: GamePhase = .showing
    @State private var userInputIndex = 0
    @State private var feedback: String? = nil
    
    private let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    enum GamePhase {
        case showing
        case userTurn
        case finished
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .bottom) {
                    HStack {
                        Image(.findSequenceGameTextRMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    HStack {
                        VStack {
                            HStack(alignment: .top) {
                                HStack {
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                        
                                    } label: {
                                        Image(.backIconRMG)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                                    }
                                    
                                }
                                Spacer()
                                
                                RMGCoinBg()
                            }.padding([.horizontal, .top])
                        }
                    }
                    
                }
                
                Spacer()
                
                if gamePhase == .showing {
                    // Full-screen reveal of each card in sequence
                    if let idx = currentStep {
                        MemorizationCardView(imageName: cardImages[idx])
                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 400:200)
                            .padding()
                            .transition(.opacity)
                    }
                } else {
                    // Grid for user interaction
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<cardImages.count, id: \.self) { index in
                            MemorizationCardView(imageName: cardImages[index])
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 240:120)
                                .onTapGesture {
                                    handleTap(on: index)
                                }
                        }
                    }.frame(width: RMGDeviceManager.shared.deviceType == .pad ? 900:450)
                    
                    
                    
                }
                
                Spacer()
                
                
            }
            
            if gamePhase == .finished {
                
                if userInputIndex >= sequenceLength {
                    ZStack {
                        Image(.winBgRMG)
                            .resizable()
                            .scaledToFit()
                        
                        VStack() {
                            
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
                                    startGame()
                                } label: {
                                    Image(.backIconRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:80)
                                        .scaleEffect(x: -1, y: 1)
                                }
                                
                                Button {
                                    startGame()
                                } label: {
                                    Image(.restartBtnRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)

                } else {
                    ZStack {
                        Image(.loseBgRMG)
                            .resizable()
                            .scaledToFit()
                        
                        VStack() {
                            
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
                                    startGame()
                                } label: {
                                    Image(.restartBtnRMG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)

                }
                
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
        .onAppear {
            startGame()
        }
        .animation(.easeInOut, value: currentStep)
    }
    
    private var headerText: String {
        switch gamePhase {
        case .showing:
            return "Watch the sequence..."
        case .userTurn:
            return "Your turn: repeat the sequence"
        case .finished:
            return feedback ?? ""
        }
    }
    
    private func startGame() {
        sequence = Array(0..<cardImages.count).shuffled().prefix(sequenceLength).map { $0 }
        userInputIndex = 0
        feedback = nil
        gamePhase = .showing
        currentStep = nil
        
        Task {
            await revealSequence()
        }
    }
    
    @MainActor
    private func revealSequence() async {
        for idx in sequence {
            currentStep = idx
            try? await Task.sleep(nanoseconds: 800_000_000)
            currentStep = nil
            try? await Task.sleep(nanoseconds: 300_000_000)
        }
        gamePhase = .userTurn
    }
    
    private func handleTap(on index: Int) {
        guard gamePhase == .userTurn else { return }
        if index == sequence[userInputIndex] {
            userInputIndex += 1
            if userInputIndex >= sequenceLength {
                feedback = "Correct! You win!"
                user.updateUserMoney(for: 100)
                gamePhase = .finished
                
            }
        } else {
            feedback = "Wrong! Try again."
            gamePhase = .finished
        }
    }
}

struct MemorizationCardView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .shadow(radius: 4)
            
    }
}


#Preview {
    RMGFindSequenceView()
}
