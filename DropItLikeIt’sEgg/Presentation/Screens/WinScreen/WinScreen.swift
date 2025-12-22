import SwiftUI

struct WinScreen: View {
    @EnvironmentObject private var appVM: ContentVM
    let score: Int
    let best: Int
    
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("YOU WIN!")
                        .customFont(size: 48)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "\(score)")
                        ScoreRow(title: "BEST", value: "\(best)")
                    }
                    
                    HStack {
                        Button {
                            appVM.popToRoot()
                        } label: {
                            Text("HOME")
                                .customFont(size: 24)
                                .underline(true)
                        }
                        
                        Spacer()
                        
                        Button {
                            appVM.openGame()
                        } label: {
                            Text("RESTART")
                                .customFont(size: 24)
                                .underline(true)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "NEXT", action: {
                    let maxLevel = appVM.maxUnlockedLevel > 6 ? 9 : 6
                    
                    if appVM.currentLevel < maxLevel {
                        appVM.openGame(level: appVM.currentLevel + 1)
                    } else if appVM.maxUnlockedLevel > 6 {
                        appVM.openEndGame()
                    } else {
                        appVM.openShop()
                    }
                })
                .padding(.horizontal, 48)
                .padding(.bottom, 48)
            }
        }
    }
}

struct ScoreRow: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appLightGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appGreen, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 60)
            
            HStack(spacing: 18) {
                Text(title)
                Spacer()
                Text(value)
            }
            .padding(.horizontal, 18)
            .customFont(size: 24)
        }
    }
}

#Preview {
    WinScreen(score: 1200, best: 1500)
        .environmentObject(ContentVM())
}
