//
//  GameScoreboardEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Diego A. Perez Pares on 10/5/23.
//  Copyright © 2023 Toptal. All rights reserved.
//

import Foundation

protocol GameScoreboardEditorViewModel {
    var homeTeam: String { get }
    var awayTeam: String { get }
    var time: String { get }
    var score: String { get }
    var isFinished: Bool { get }
    var isPaused: Bool { get }
    var homePlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    var awayPlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    func togglePause();
}
