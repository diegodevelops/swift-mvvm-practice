//
//  GameScoreboardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by Diego A. Perez Pares on 10/5/23.
//  Copyright © 2023 Toptal. All rights reserved.
//

import Foundation

import Foundation

class GameScoreboardEditorViewModelFromGame: NSObject, GameScoreboardEditorViewModel {
    
    let game: Game
    
    struct Formatter {
        static let durationFormatter: DateComponentsFormatter = {
            let dateFormatter = DateComponentsFormatter()
            dateFormatter.unitsStyle = .positional
            return dateFormatter
        }()
    }
    
    // MARK: GameScoreboardEditorViewModel protocol
    
    var homeTeam: String
    var awayTeam: String
    
    var time: String
    var score: String
    var isFinished: Bool
    
    var isPaused: Bool
    func togglePause() {
        if isPaused {
            startTimer()
        } else {
            pauseTimer()
        }
        
        self.isPaused = !isPaused
    }
    
    let homePlayers: [PlayerScoreboardMoveEditorViewModel]
    let awayPlayers: [PlayerScoreboardMoveEditorViewModel]
    
    // MARK: Init
    
    init(withGame game: Game) {
        self.game = game
        
        self.homeTeam = game.homeTeam.name
        self.awayTeam = game.awayTeam.name
        
        self.time = GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: game)
        self.score = GameScoreboardEditorViewModelFromGame.scorePretty(for: game)
        self.isFinished = game.isFinished
        self.isPaused = true
        
        self.homePlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.homeTeam.players, game: game)
        self.awayPlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.awayTeam.players, game: game)
    }
    
    
    fileprivate static func playerViewModels(from players: [Player], game: Game) -> [PlayerScoreboardMoveEditorViewModel] {
        var playerViewModels: [PlayerScoreboardMoveEditorViewModel] = [PlayerScoreboardMoveEditorViewModel]()
        for player in players {
            playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
        }
        
        return playerViewModels
    }
    
    // MARK: Private
    
    fileprivate var gameTimer: Timer?
    fileprivate func startTimer() {
        let interval: TimeInterval = 0.001
        gameTimer = Timer.schedule(repeatInterval: interval) { timer in
            self.game.time += interval
            self.time = GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: self.game)
        }
    }
    
    fileprivate func pauseTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    // MARK: String Utils
    
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        let millis: Int = totalMillis % 1000 / 100 // "/ 100" <- because we want only 1 digit
        let totalSeconds: Int = totalMillis / 1000
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        
        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    }
    
    fileprivate static func timeRemainingPretty(for game: Game) -> String {
        return timeFormatted(totalMillis: Int(game.time * 1000))
    }
    
    fileprivate static func scorePretty(for game: Game) -> String {
        return String(format: "\(game.homeTeamScore) - \(game.awayTeamScore)")
    }
    
}
