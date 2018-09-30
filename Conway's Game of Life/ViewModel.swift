//
// Created by Karl Sigiscar on 30/09/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class ViewModel : Tickable {
    var game:ConwayGameOfLife!
    var timer:Timer!

    init() {
        game =  ConwayGameOfLife(width: 50, height: 50)
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(tick), userInfo: nil, repeats:true)
    }

    @objc func tick() {
        // Forward invocation to the game
        game.tick()
    }
}
