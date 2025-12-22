import SwiftUI

struct LoseScreen: View {
    @EnvironmentObject private var appVM: ContentVM
    let score: Int
    let best: Int
    
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("YOU LOSE!")
                        .customFont(size: 48)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "\(score)")
                        ScoreRow(title: "BEST", value: "\(best)")
                    }
                    
                    Button {
                        appVM.popToRoot()
                    } label: {
                        Text("HOME")
                            .customFont(size: 24)
                            .underline(true)
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "TRY AGAIN", action: {
                    appVM.openGame()
                })
                .padding(.horizontal, 56)
                .padding(.bottom, 48)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoseScreen(score: 500, best: 1200)
        .environmentObject(ContentVM())
}
