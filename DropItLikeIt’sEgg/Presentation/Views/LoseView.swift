import SwiftUI

struct LoseView: View {
    let score: Int
    let best: Int
    let appVM: ContentVM
    
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
                    appVM.openGame(level: appVM.currentLevel)
                })
                .padding(.horizontal, 56)
                .padding(.bottom, 48)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoseView(score: 500, best: 1200, appVM: ContentVM(Services.shared))
        .environmentObject(ContentVM(Services.shared))
}
