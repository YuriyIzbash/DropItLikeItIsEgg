import SwiftUI

struct GameScreen: View {
    @EnvironmentObject private var appVM: ContentVM
    @StateObject var vm: GameScreenVM
    @State private var isReady = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStackWithBackground(.backgroundGame) {
                gameLayer(size: proxy.size)
            }
            .onAppear { 
                if !isReady {
                    vm.configure(level: appVM.currentLevel)
                    vm.start(with: proxy.size)
                    isReady = true
                }
            }
            .onDisappear {
                vm.pause()
            }
            .onChange(of: appVM.profile.score) { newScore in
                if vm.score != newScore && !vm.isLoadingScore {
                    vm.syncScore()
                }
            }
            .onChange(of: vm.score) { newValue in
                guard !vm.isLoadingScore else { return }
                
                appVM.profile.score = newValue
                appVM.saveProfile()
                if newValue == 0 {
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
            BlastView(
                blast: blast,
                size: size
            )
        }
    }
    
    func coinLayer(size: CGSize) -> some View {
        let coinSize = vm.coinSize(for: size.width)
        let playerHeight = vm.playerSize(for: size.width).height
        let groundY = size.height - playerHeight/2
        return ZStack {
            ForEach(vm.coins) { coin in
                let halfH = coinSize.height / 2
                let groundTop = groundY
                if coin.y < groundTop {
                    Image(coin.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: coinSize.width, height: coinSize.height)
                        .position(
                            x: coin.x * size.width,
                            y: coin.y
                        )
                }
            }
            
            if vm.coinEffect != nil {
                Image(.coin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .position(
                        x: vm.playerX * size.width,
                        y: size.height - vm.playerSize(for: size.width).height - 40
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



