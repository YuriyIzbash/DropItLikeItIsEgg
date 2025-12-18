//
//  ProgressView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct ProgressView: View {
    @State private var progress: CGFloat = 0
    @State private var isAnimating = false
    @State private var showHome = false
    
    private let barSize = CGSize(width: 350, height: 50)
    
    var body: some View {
        ZStack {
            if showHome {
                HomeScreen()
                    .transition(.opacity)
            } else {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .background(
                        ZStack {
                            Image("backgroundMain")
                                .resizable()
                                .scaledToFill()
                            
                            Image("chicken-1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .bottom)
                        }
                            .ignoresSafeArea()
                    )
                    .overlay(
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.95))
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        colors: [Color("gradientOrange"), Color("gradientYellow")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: barSize.width * max(0, min(progress, 1)), height: barSize.height)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(LinearGradient(
                                    colors: [Color("gradientOrange"), Color("gradientYellow")],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ), lineWidth: 2)
                            
                            Text("\(Int(progress * 100))%")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.subtitle)
                                .textOutline(width: 1, color: .textOutline)
                                .appTextStyle()
                        }
                            .frame(width: barSize.width, height: barSize.height)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 48)
                    )
                    .onAppear {
                        guard !isAnimating else { return }
                        isAnimating = true
                        progress = 0
                        
                        withAnimation(.easeInOut(duration: 1.5)) {
                            progress = 0.34
                        }
                        
                        withAnimation(.easeInOut(duration: 2.5)) {
                            progress = 0.72
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 + 0.5) {
                            withAnimation(.easeIn(duration: 0.8)) {
                                progress = 1.0
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.5 + 0.8) {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showHome = true
                            }
                        }
                    }
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    ProgressView()
}
