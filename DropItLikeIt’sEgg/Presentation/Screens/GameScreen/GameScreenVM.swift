import SwiftUI
import Combine

@MainActor
final class GameScreenVM: ObservableObject {
    enum GameResult {
        case win
        case lose
    }
    
    struct Egg: Identifiable {
        let id = UUID()
        let image: ImageResource
        var x: CGFloat      // 0...1 relative to screen width
        var y: CGFloat      // center Y in points
        var fallSpeed: CGFloat
    }
    
    struct Blast: Identifiable {
        let id = UUID()
        var x: CGFloat      // 0...1 relative to screen width
        var createdAt: Date
    }
    
    struct CoinEffect {
        let id = UUID()
        let createdAt: Date
    }
    
    @Published var isPaused: Bool = false
    @Published var score: Int = 1000
    @Published var bestScore: Int = 0
    @Published var playerX: CGFloat = 0.5
    @Published var eggs: [Egg] = []
    @Published var blasts: [Blast] = []
    @Published var coinEffect: CoinEffect?
    @Published var gameResult: GameResult?
    
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    private var totalEggs: Int = 24
    private var speedRange: ClosedRange<CGFloat> = 150...210
    private let eggImages: [ImageResource] = [.egg1, .egg2, .egg3, .egg4, .egg5, .egg6, .egg7, .egg8, .egg9, .egg10, .egg11, .egg12]
    private let spawnIntervalRange: ClosedRange<Double> = 0.7...1.3
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    private var handledEggs: Int = 0
    private var caughtEggs: Int = 0
    private var lastUpdate: Date?
    private var spawnCooldown: Double = 0
    private var sceneSize: CGSize = .zero
    
    private let bottomPadding: CGFloat = 28
    
    func configure(level: Int) {
        switch level {
        case 1:
            totalEggs = 24
            speedRange = 150...210
        case 2:
            totalEggs = 30
            speedRange = 200...260
        case 3:
            totalEggs = 36
            speedRange = 250...310
        case 4:
            totalEggs = 42
            speedRange = 300...360
        case 5:
            totalEggs = 48
            speedRange = 350...410
        default: // level 6 and above
            totalEggs = 54
            speedRange = 400...460
        }
    }
    
    func start(with size: CGSize) {
        sceneSize = size
        resetState()
        loadStoredScore()
    }
    
    func tick(currentTime: Date) {
        guard gameResult == nil else { return }
        guard !isPaused else { lastUpdate = currentTime; return }
        
        let delta = lastUpdate.map { currentTime.timeIntervalSince($0) } ?? 0
        lastUpdate = currentTime
        
        spawnCooldown -= delta
        if spawnCooldown <= 0, (handledEggs + eggs.count) < totalEggs {
            spawnEgg()
            spawnCooldown = Double.random(in: spawnIntervalRange)
        }
        
        moveEggs(delta: delta)
        trimEffects(currentTime: currentTime)
    }
    
    func movePlayer(to normalizedX: CGFloat) {
        playerX = min(max(normalizedX, 0.08), 0.92)
    }
    
    func togglePause() { isPaused.toggle() }
    func pause() { isPaused = true }
    func resume() { isPaused = false }
    
    func playerSize(for width: CGFloat) -> CGSize {
        let w = max(width * 0.25, 120)
        return CGSize(width: w, height: w * 1.15)
    }
    
    func eggSize(for width: CGFloat) -> CGSize {
        let w = max(width * 0.11, 44)
        return CGSize(width: w, height: w * 1.15)
    }
    
    private func resetState() {
        isPaused = false
        gameResult = nil
        handledEggs = 0
        caughtEggs = 0
        lastUpdate = nil
        spawnCooldown = 0
        eggs.removeAll()
        blasts.removeAll()
        coinEffect = nil
    }
    
    private func loadStoredScore() {
        let stored = profileSaver.getValue()
        let startingScore = max(stored?.score ?? 0, 1000)
        score = startingScore
        bestScore = max(stored?.score ?? startingScore, startingScore)
    }
    
    private func moveEggs(delta: TimeInterval) {
        guard sceneSize.width > 0 else { return }
        let eggSize = eggSize(for: sceneSize.width)
        let playerSize = playerSize(for: sceneSize.width)
        let groundY = sceneSize.height - bottomPadding
        
        let playerRect = CGRect(
            x: playerX * sceneSize.width - playerSize.width/2,
            y: groundY - playerSize.height,
            width: playerSize.width,
            height: playerSize.height
        )
        
        for index in eggs.indices.reversed() {
            eggs[index].y += eggs[index].fallSpeed * CGFloat(delta)
            
            let eggOriginY = eggs[index].y - eggSize.height/2
            let eggRect = CGRect(
                x: eggs[index].x * sceneSize.width - eggSize.width/2,
                y: eggOriginY,
                width: eggSize.width,
                height: eggSize.height
            )
            
            if eggRect.intersects(playerRect) {
                handleCatch(at: index)
                continue
            }
            
            if eggRect.maxY >= groundY {
                handleMiss(at: index)
                continue
            }
        }
    }
    
    private func spawnEgg() {
        guard sceneSize.width > 0 else { return }
        let initialY = -eggSize(for: sceneSize.width).height
        let egg = Egg(
            image: eggImages.randomElement() ?? .egg1,
            x: CGFloat.random(in: 0.08...0.92),
            y: initialY,
            fallSpeed: CGFloat.random(in: speedRange)
        )
        eggs.append(egg)
    }
    
    private func handleCatch(at index: Int) {
        eggs.remove(at: index)
        caughtEggs += 1
        handledEggs += 1
        score += 10
        coinEffect = CoinEffect(createdAt: Date())
        persistScore()
        checkOutcome()
    }
    
    private func handleMiss(at index: Int) {
        let egg = eggs.remove(at: index)
        handledEggs += 1
        score = max(score - 100, 0)
        blasts.append(Blast(x: egg.x, createdAt: Date()))
        persistScore()
        checkOutcome()
    }
    
    private func trimEffects(currentTime: Date) {
        blasts.removeAll { currentTime.timeIntervalSince($0.createdAt) > 0.6 }
        if let coinEffect, currentTime.timeIntervalSince(coinEffect.createdAt) > 0.6 {
            self.coinEffect = nil
        }
    }
    
    private func checkOutcome() {
        if score <= 0 {
            score = 0
            gameResult = .lose
            return
        }
        
        if caughtEggs >= totalEggs {
            bestScore = max(bestScore, score)
            persistScore()
            gameResult = .win
            return
        }
        
        if handledEggs >= totalEggs {
            gameResult = .lose
        }
    }
    
    private func persistScore() {
        var profile = profileSaver.getValue() ?? UserProfile(score: score)
        profile.score = score
        profileSaver.save(profile)
    }
}
