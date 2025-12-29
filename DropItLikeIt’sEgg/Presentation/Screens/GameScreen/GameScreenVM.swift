//
//  GameScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI
import Combine

@MainActor
final class GameScreenVM: BaseModel {
    @Published var isPaused: Bool = false
    @Published private(set) var score: Int = 0
    @Published private(set) var bestScore: Int = 0
    @Published private(set) var playerX: CGFloat = 0.5
    @Published private(set) var eggs: [Egg] = []
    @Published private(set) var coins: [Coin] = []
    @Published private(set) var blasts: [Blast] = []
    @Published private(set) var coinEffect: CoinEffect?
    @Published private(set) var gameResult: GameResult?
    
    var isLoadingScore: Bool = false
    
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    private var totalEggs: Int = 24
    private var speedRange: ClosedRange<CGFloat> = 150...210
    private let eggImages: [ImageResource] = [.egg1, .egg2, .egg3, .egg4, .egg5, .egg6, .egg7, .egg8, .egg9, .egg10, .egg11, .egg12]
    private let coinImages: [ImageResource] = [.coin1, .coin2, .coin3]
    private let spawnIntervalRange: ClosedRange<Double> = 0.7...1.3
    private let coinSpawnIntervalRange: ClosedRange<Double> = 1.4...3.9
    private var handledEggs: Int = 0
    private var caughtEggs: Int = 0
    private var coinsSpawned: Int = 0
    private var lastUpdate: Date?
    private var spawnCooldown: Double = 0
    private var coinSpawnCooldown: Double = 0
    private var sceneSize: CGSize = .zero
    
    private let bottomPadding: CGFloat = 28
    
    private let maxCoinsPerLevel: Int = 9
    
    func configure(level: Int) {
        switch level {
        case 1:
            totalEggs = 24
            speedRange = 150...250
        case 2:
            totalEggs = 30
            speedRange = 150...300
        case 3:
            totalEggs = 36
            speedRange = 150...350
        case 4:
            totalEggs = 42
            speedRange = 150...450
        case 5:
            totalEggs = 48
            speedRange = 150...500
        case 6:
            totalEggs = 48
            speedRange = 150...550
        case 7:
            totalEggs = 48
            speedRange = 150...650
        case 8:
            totalEggs = 48
            speedRange = 150...700
        case 9:
            totalEggs = 48
            speedRange = 150...750
        default:
            totalEggs = 54
            speedRange = 150...500
        }
    }
    
    func start(with size: CGSize) {
        sceneSize = size
        resetState()
        loadStoredScore()
    }
    
    func syncScore() {
        isLoadingScore = true
        loadStoredScore()
        isLoadingScore = false
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
        
        coinSpawnCooldown -= delta
        if coinSpawnCooldown <= 0, coinsSpawned < maxCoinsPerLevel {
            spawnCoin()
            coinSpawnCooldown = Double.random(in: coinSpawnIntervalRange)
        }
        
        moveEggs(delta: delta)
        moveCoins(delta: delta)
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
    
    func coinSize(for width: CGFloat) -> CGSize {
        let baseSize = eggSize(for: width)
        let multiplier: CGFloat = 2.5
        return CGSize(width: baseSize.width * multiplier, height: baseSize.height * multiplier)
    }
    
    func groundLine(for size: CGSize) -> CGFloat {
        let playerSize = playerSize(for: size.width)
        let playerCenterY = size.height - playerSize.height/2 - 12
        let playerTopY = playerCenterY - playerSize.height/2
        return playerTopY
    }
    
    private func resetState() {
        isPaused = false
        gameResult = nil
        handledEggs = 0
        caughtEggs = 0
        lastUpdate = nil
        spawnCooldown = 0
        coinSpawnCooldown = 0
        coinsSpawned = 0
        eggs.removeAll()
        coins.removeAll()
        blasts.removeAll()
        coinEffect = nil
    }
    
    private func loadStoredScore() {
        let stored = userProfileService.load()
        isLoadingScore = true
        score = stored?.score ?? 0
        bestScore = stored?.score ?? 0
        isLoadingScore = false
    }
    
    private func moveEggs(delta: TimeInterval) {
        guard sceneSize.width > 0 else { return }
        let eggSize = eggSize(for: sceneSize.width)
        let playerSize = playerSize(for: sceneSize.width)
        let groundY = groundLine(for: sceneSize)
        
        let playerCenterY = sceneSize.height - playerSize.height/2 - 12
        let playerRect = CGRect(
            x: playerX * sceneSize.width - playerSize.width/2,
            y: playerCenterY - playerSize.height/2,
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
            
            if eggs[index].y >= groundY {
                handleMiss(at: index)
                continue
            }
        }
    }
    
    private func moveCoins(delta: TimeInterval) {
        guard sceneSize.width > 0 else { return }
        let coinSize = coinSize(for: sceneSize.width)
        let playerSize = playerSize(for: sceneSize.width)
        let groundY = groundLine(for: sceneSize)
        
        let playerCenterY = sceneSize.height - playerSize.height/2 - 12
        let playerRect = CGRect(
            x: playerX * sceneSize.width - playerSize.width/2,
            y: playerCenterY - playerSize.height/2,
            width: playerSize.width,
            height: playerSize.height
        )
        
        for index in coins.indices.reversed() {
            coins[index].y += coins[index].fallSpeed * CGFloat(delta)
            
            let coinOriginY = coins[index].y - coinSize.height/2
            let coinRect = CGRect(
                x: coins[index].x * sceneSize.width - coinSize.width/2,
                y: coinOriginY,
                width: coinSize.width,
                height: coinSize.height
            )
            
            if coinRect.intersects(playerRect) {
                handleCoinCatch(at: index)
                continue
            }
            
            let coinBottomY = coins[index].y
            let coinGroundLine = groundY
            if coinBottomY >= coinGroundLine {
                handleCoinGround(at: index)
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
    
    private func spawnCoin() {
        guard sceneSize.width > 0 else { return }
        let initialY = -coinSize(for: sceneSize.width).height
        let image = coinImages.randomElement() ?? .coin1
        let value: Int
        switch image {
        case .coin1: value = 20
        case .coin2: value = 30
        case .coin3: value = 50
        default: value = 20
        }
        let coin = Coin(
            image: image,
            x: CGFloat.random(in: 0.08...0.92),
            y: initialY,
            fallSpeed: CGFloat.random(in: speedRange),
            value: value
        )
        coins.append(coin)
        coinsSpawned += 1
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
        
        let groundY = groundLine(for: sceneSize)
        
        blasts.append(Blast(x: egg.x, y: groundY, createdAt: Date()))
        persistScore()
        checkOutcome()
    }
    
    private func handleCoinCatch(at index: Int) {
        let coin = coins.remove(at: index)
        score += coin.value
        coinEffect = CoinEffect(createdAt: Date())
        persistScore()
    }
    
    private func handleCoinGround(at index: Int) {
        coins.remove(at: index)
    }
    
    private func trimEffects(currentTime: Date) {
        blasts.removeAll { currentTime.timeIntervalSince($0.createdAt) > 0.6 }
        if let coinEffect, currentTime.timeIntervalSince(coinEffect.createdAt) > 0.6 {
            self.coinEffect = nil
        }
    }
    
    private func checkOutcome() {
        if handledEggs >= totalEggs {
            if caughtEggs >= totalEggs {
                gameResult = .win
            } else {
                gameResult = .lose
            }
            
            if score > bestScore {
                bestScore = score
                persistBestScore()
            }
            return
        }
        
        
        if score < 0 {
            score = 0
        }
    }
    
    private func persistScore() {
        var profile = userProfileService.load() ?? UserProfile(score: score)
        profile.score = score
        userProfileService.save(profile)
    }
    
    private func persistBestScore() {
        var profile = userProfileService.load() ?? UserProfile(score: bestScore)
        profile.score = bestScore
        userProfileService.save(profile)
    }
}

extension GameScreenVM {
    enum GameResult {
        case win
        case lose
    }
    
    struct Egg: Identifiable {
        let id = UUID()
        let image: ImageResource
        var x: CGFloat
        var y: CGFloat
        var fallSpeed: CGFloat
    }
    
    struct Coin: Identifiable {
        let id = UUID()
        let image: ImageResource
        var x: CGFloat
        var y: CGFloat
        var fallSpeed: CGFloat
        var value: Int
    }
    
    struct Blast: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var createdAt: Date
    }
    
    struct CoinEffect {
        let id = UUID()
        let createdAt: Date
    }
    
}
