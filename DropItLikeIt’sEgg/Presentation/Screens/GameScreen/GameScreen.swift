import SwiftUI

struct GameScreen: View {
    @EnvironmentObject private var appVM: ContentVM
    @StateObject var vm: GameScreenVM
    
    var body: some View {
        GeometryReader { proxy in
            ZStackWithBackground(.backgroundGame) {
                gameLayer(size: proxy.size)
            }
            .onAppear { 
                vm.configure(level: appVM.currentLevel)
                vm.start(with: proxy.size)
            }
            .onDisappear {
                // When leaving game screen (e.g., going to shop), pause the game
                vm.pause()
            }
            .onChange(of: appVM.profile.score) { newScore in
                // When profile score changes (e.g., coins added in shop), sync to VM
                if vm.score != newScore && !vm.isLoadingScore {
                    vm.syncScore()
                }
            }
            .onChange(of: vm.score) { newValue in
                // Don't sync back to appVM if we're loading from storage
                guard !vm.isLoadingScore else { return }
                
                appVM.profile.score = newValue
                appVM.saveProfile()
                if newValue == 0 {
                    // Present Shop when out of coins
                    appVM.path.append(.shop)
                }
            }
            .onReceive(vm.timer) { vm.tick(currentTime: $0) }
            .overlay(alignment: .top) {
                topBar
            }
            .overlay(alignment: .center) {
                pauseOverlay
            }
            .overlay(alignment: .center) {
                resultOverlay
            }
        }
    }
}

private extension GameScreen {
    var topBar: some View {
        ZStack(alignment: .trailing) {
            CoinCounterView(amount: appVM.profile.score, isInteractive: false)
                .frame(maxWidth: .infinity, alignment: .center)
            
            NavBtn(type: .pause) {
                vm.pause()
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 8)
    }
    
    func gameLayer(size: CGSize) -> some View {
        let drag = DragGesture(minimumDistance: 0)
            .onChanged { value in
                vm.movePlayer(to: value.location.x / size.width)
            }
        
        return ZStack(alignment: .bottomLeading) {
            eggsLayer(size: size)
            blastsLayer(size: size)
            coinLayer(size: size)
            playerLayer(size: size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(drag)
    }
    
    func eggsLayer(size: CGSize) -> some View {
        let eggSize = vm.eggSize(for: size.width)
        return ForEach(vm.eggs) { egg in
            Image(egg.image)
                .resizable()
                .scaledToFit()
                .frame(width: eggSize.width, height: eggSize.height)
                .position(
                    x: egg.x * size.width,
                    y: egg.y
                )
        }
    }
    
    func blastsLayer(size: CGSize) -> some View {
        ForEach(vm.blasts) { blast in
            Image(.blast)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .position(
                    x: blast.x * size.width,
                    y: size.height - 20
                )
                .transition(.opacity)
        }
    }
    
    func coinLayer(size: CGSize) -> some View {
        Group {
            if vm.coinEffect != nil {
                Image(.coin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .position(
                        x: vm.playerX * size.width,
                        y: size.height - vm.playerSize(for: size.width).height - 60
                    )
                    .transition(.opacity)
            }
        }
    }
    
    func playerLayer(size: CGSize) -> some View {
        let playerSize = vm.playerSize(for: size.width)
        return Image(.chicken1)
            .resizable()
            .scaledToFit()
            .frame(width: playerSize.width, height: playerSize.height)
            .position(
                x: vm.playerX * size.width,
                y: size.height - playerSize.height/2 - 12
            )
    }
    
    @ViewBuilder
    var pauseOverlay: some View {
        if vm.isPaused {
            PauseView(isPresented: $vm.isPaused)
                .transition(.opacity)
                .animation(.easeInOut, value: vm.isPaused)
        }
    }
    
    @ViewBuilder
    var resultOverlay: some View {
        switch vm.gameResult {
        case .win:
            WinScreen(score: vm.score, best: vm.bestScore)
        case .lose:
            LoseScreen(score: vm.score, best: vm.bestScore)
        case .none:
            EmptyView()
        }
    }
}

