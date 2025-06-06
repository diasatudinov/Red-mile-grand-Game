import SwiftUI

struct RMGMatchTheCardView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var user = RMGUser.shared
    
    @State private var cards: [MGCard] = []
    @State private var selectedCards: [MGCard] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var isWin: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = [
        "cardFace1RMG",
        "cardFace2RMG",
        "cardFace3RMG",
        "cardFace4RMG",
        "cardFace5RMG",
        "cardFace6RMG"]
    private let gridSize = 4
    
    @State private var counter: Int = 0
    
    @State private var timeLeft: Int = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if !gameEnded {
                VStack {
                    ZStack {
                        
                        HStack {
                            
                            Image(.timerBgRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 180:90)
                                .opacity(0)
                            
                            Image(.findCoupleTextRMG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 210:91)
                            
                            ZStack {
                                Image(.timerBgRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 180:90)
                                
                                Text("\(timeLeft)")
                                    .font(.system(size: RMGDeviceManager.shared.deviceType == .pad ? 60:30, weight: .black))
                                    .foregroundStyle(.black)
                                    .offset(x: RMGDeviceManager.shared.deviceType == .pad ? -40:-20, y: RMGDeviceManager.shared.deviceType == .pad ? 14:7)
                            }
                        }
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                            } label: {
                                Image(.backIconRMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 100:50)
                            }
                            
                            Spacer()
                            
                        }.padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 0) {
                            ForEach(cards) { card in
                                MGCardView(card: card)
                                    .onTapGesture {
                                        flipCard(card)
                                        
                                    }
                                    .opacity(card.isMatched ? 0.5 : 1.0)
                            }
                            
                        }
                    }
                    
                    Spacer()
                }
                .onAppear {
                    setupGame()
                }
            }
            if gameEnded {
                if isWin {
                    VStack {
                        Spacer()
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
                                        setupGame()
                                    } label: {
                                        Image(.backIconRMG)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:80)
                                            .scaleEffect(x: -1, y: 1)
                                    }
                                    
                                    Button {
                                        setupGame()
                                    } label: {
                                        Image(.restartBtnRMG)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                    }
                                }
                                
                            }
                        }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)
                        Spacer()
                    }
                } else {
                    VStack {
                        Spacer()
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
                                        setupGame()
                                    } label: {
                                        Image(.restartBtnRMG)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 120:60)
                                    }
                                }
                                
                            }
                        }.frame(height: RMGDeviceManager.shared.deviceType == .pad ? 600:300)
                        Spacer()
                    }
                    
                }
            }
            
            
        }
        .onReceive(timer) { _ in
            guard !gameEnded else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                gameEnded = true
                isWin = false
                timer.upstream.connect().cancel()
            }
        }
       
        .background(
            Image(.appBgRMG)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
        }
    }
    
    private func setupGame() {
        // Reset state
        selectedCards.removeAll()
        message = "Find all matching cards!"
        gameEnded = false
        timeLeft = 60
        // Restart timer
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        // Generate cards
        var gameCards = [MGCard]()
        
        // Add 4 cards of each type (24 cards total for 6 types)
        for type in cardTypes {
            gameCards.append(MGCard(type: type))
            gameCards.append(MGCard(type: type))
        }
        
        // Shuffle cards
        gameCards.shuffle()
        
        // Ensure exactly 25 cards
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: MGCard) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 2 else { return }
        
        // Flip card
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        if card.type == "cardSemaphore" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resetAllCards()
            }
        } else if selectedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            message = "You found a match! Keep going!"
            isWin = true
        } else {
            message = "Not a match. Try again!"
            isWin = false
        }
        
        // Flip cards back over after a delay if they don't match
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
                user.updateUserMoney(for: 100)
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            
            cards[index].isMatched = false
            
        }
        selectedCards.removeAll()
    }
    
}

#Preview {
    RMGMatchTheCardView()
}

struct MGCardView: View {
    let card: MGCard
    
    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.type)
                    .resizable()
                    .scaledToFit()
                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 200:120)
            } else {
                Image(.cardBackRMG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: RMGDeviceManager.shared.deviceType == .pad ? 200:120)
            }
        }
    }
}


struct MGCard: Identifiable {
    let id = UUID()
    let type: String
    var isFaceUp = false
    var isMatched = false
}
