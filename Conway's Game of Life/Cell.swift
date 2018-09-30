//
// Created by Karl Sigiscar on 29/09/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class Cell : Tickable {
    var isLive:Bool = Bool.random()
    var newValue:Bool = false
    var neighbours:[Cell]!

    var numberOfLiveNeighbours:Int {
        get {
            return neighbours.filter({ $0.isLive == true }).count
        }
    }

    func tick() {

        // Any live cell with fewer than two live neighbors dies, as if by under population.

        if self.isLive == true && self.numberOfLiveNeighbours < 2 {
            newValue = false
        }

        // Any live cell with two or three live neighbors lives on to the next generation.

        else if self.isLive == true && (self.numberOfLiveNeighbours == 2 || self.numberOfLiveNeighbours == 3) {
            newValue = true
        }

        // Any live cell with more than three live neighbors dies, as if by overpopulation.

        else if self.isLive == true && self.numberOfLiveNeighbours > 3 {
            newValue = false
        }

        // Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

        else if self.isLive == false && self.numberOfLiveNeighbours == 3 {
            newValue = true
        }
    }

    func valueCommit() {
        isLive = newValue
    }
}
