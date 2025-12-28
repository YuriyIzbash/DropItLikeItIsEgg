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
    @Published var bestScore: Int = 1000
    @Published var playerX: CGFloat = 0.5
    @Published var eggs: [Egg] = []
    @Published var blasts: [Blast] = []
    @Published var coinEffect: CoinEffect?
    @Published var gameResult: GameResult?
    
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    private let level: Int
    private var totalEggs: Int {
        // Level 1: 24 eggs, Level 2: 30, Level 3: 36, Level 4: 42, Level 5: 48, Level 6: 54
        return 24 + (level - 1) * 6
    }
    
    private var baseFallSpeed: CGFloat {
        // Level 1: 180-260, Level 2: 200-280, Level 3: 220-300, Level 4: 240-320, Level 5: 260-340, Level 6: 280-360
        let baseMin: CGFloat = 180 + CGFloat(level - 1) * 20
        let baseMax: CGFloat = 260 + CGFloat(level - 1) * 20
        return baseMin
    }
    
    private var fallSpeedRange: ClosedRange<CGFloat> {
        let minSpeed: CGFloat = 180 + CGFloat(level - 1) * 20
        let maxSpeed: CGFloat = 260 + CGFloat(level - 1) * 20
        return minSpeed...maxSpeed
    }
    
    private let eggImages: [ImageResource] = [.egg1, .egg2, .egg3, .egg4, .egg5, .egg6, .egg7, .egg8, .egg9, .egg10, .egg11, .egg12]
    private let spawnIntervalRange: ClosedRange<Double> = 0.7...1.3
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    private var handledEggs: Int = 0
    private var caughtEggs: Int = 0
    private var lastUpdate: Date?
    private var spawnCooldown: Double = 0
    private var sceneSize: CGSize = .zero
    
    private let bottomPadding: CGFloat = 28
    
    init(level: Int = 1) {
        self.level = max(1, min(6, level)) // Clamp between 1 and 6
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
            fallSpeed: CGFloat.random(in: fallSpeedRange)
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
