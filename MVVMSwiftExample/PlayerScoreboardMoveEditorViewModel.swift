//
//  PlayerScoreboardMoveEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Diego A. Perez Pares on 10/5/23.
//  Copyright © 2023 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardMoveEditorViewModel {
    var playerName: String { get }
    
    var onePointMoveCount: String { get }
    var twoPointMoveCount: String { get }
    var assistMoveCount: String { get }
    var reboundMoveCount: String { get }
    var foulMoveCount: String { get }
    
    func onePointMove()
    func twoPointsMove()
    func assistMove()
    func reboundMove()
    func foulMove()
}
