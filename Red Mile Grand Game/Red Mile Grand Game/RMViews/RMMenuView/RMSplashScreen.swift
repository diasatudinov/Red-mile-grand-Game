//
//  RMSplashScreen.swift
//  Red Mile Grand Game
//
//  Created by Dias Atudinov on 03.06.2025.
//

import SwiftUI

struct RMSplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            Image(.appBgRM)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
              
                
                Image(.loadingLogoRM)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 210)
                
                Image(.loadingTextRM)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.bottom, 15)
                
                ZStack {
                    Image(.loaderBorderRM)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.loaderBgRM)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 385)
                        .colorMultiply(.gray)
                    
                    Image(.loaderBgRM)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 385)
                        .mask(
                            Rectangle()
                                .frame(width: progress * 385)
                                .padding(.trailing, (1 - progress) * 385)
                        )
                }
                .frame(width: 400)
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}


#Preview {
    RMSplashScreen()
}
