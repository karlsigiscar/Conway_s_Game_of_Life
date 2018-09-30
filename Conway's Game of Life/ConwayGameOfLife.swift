//
// Created by Karl Sigiscar on 29/09/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class ConwayGameOfLife : Tickable {
    
    var grid:[[Cell]] = []
    
    var gridWidth:Int {
        get {
            return grid[0].count
        }
    }
    
    var gridHeight:Int {
        get {
            return grid.count
        }
    }

    init(width: Int, height: Int) {
        initializeGrid(height: height, width: width)
    }

    private func initializeGrid(height: Int, width: Int) {
        for _ in 0 ..< height {
            var row = [Cell]()
            for _ in 0 ..< width {
                let cell = Cell()
                row.append(cell)
            }
            grid.append(row)
        }
        initializeCellsNeighbours()
    }

    func initializeCellsNeighbours() {

        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0 ..< row.count {

                let cell:Cell = row[x]
                var neighbours = [Cell]()
                var i:Int
                var j:Int
                var neighbouringCell:Cell

                // -------------------------
                // Left hand side neighbours
                // -------------------------

                // Left of the cell, same row

                if x > 0 {
                    i = x - 1
                    j = y
                    neighbouringCell = row[i]
                    neighbours.append(neighbouringCell)
                }

                // Left of the cell, row above

                if x > 0 {
                    if y > 0 {
                        i = x - 1
                        j = y - 1
                        let aboveRow:[Cell] = grid[j]
                        neighbouringCell = aboveRow[i]
                        neighbours.append(neighbouringCell)
                    }
                }

                // Left of the cell, row below

                if x > 0 {
                    if y < grid.count - 1  {
                        i = x - 1
                        j = y + 1
                        let belowRow:[Cell] = grid[j]
                        neighbouringCell = belowRow[i]
                        neighbours.append(neighbouringCell)
                    }
                }

                // --------------------------
                // Right hand side neighbours
                // --------------------------

                // Right of the cell, same row

                if x < row.count - 1 {
                    i = x + 1
                    j = y
                    neighbouringCell = grid[x][y]
                    neighbours.append(neighbouringCell)
                }

                // Right of the cell, row above

                if x < row.count - 1 {
                    if y > 0 {
                        i = x + 1
                        j = y - 1
                        let aboveRow: [Cell] = grid[j]
                        neighbouringCell = aboveRow[i]
                        neighbours.append(neighbouringCell)
                    }
                }

                // Right of the cell, row below

                if x < row.count - 1 {
                    if y < grid.count - 1  {
                        i = x + 1
                        j = y + 1
                        let belowRow: [Cell] = grid[j]
                        neighbouringCell = belowRow[i]
                        neighbours.append(neighbouringCell)
                    }
                }

                // -----------------------------
                // Neighbours in the same column
                // -----------------------------

                // Same column, row above

                if y > 0 {
                    i = x
                    j = y - 1
                    let aboveRow:[Cell] = grid[j]
                    neighbouringCell = aboveRow[i]
                    neighbours.append(neighbouringCell)
                }

                // Same column, row below

                if y < grid.count - 1  {
                    i = x
                    j = y + 1
                    let belowRow:[Cell] = grid[j]
                    neighbouringCell = belowRow[i]
                    neighbours.append(neighbouringCell)
                }

                cell.neighbours = neighbours
            }
        }
    }

    // MARK: Tick

    func tick() {

        // Make all the cells tick

        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0..<row.count {
                let cell: Cell = row[x]
                // Forward invocation to the cell
                cell.tick()
            }
        }

        // Commit the new values

        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0..<row.count {
                let cell: Cell = row[x]
                cell.valueCommit()
            }
        }
        
        NotificationCenter.default.post(name: .tick, object: self, userInfo: ["grid":grid])
    }

    // MARK: Test Helper methods

    func getLiveCellsWithFewerThanTwoLiveNeighbours() -> [Cell] {

        var result = [Cell]()
        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0 ..< row.count {
                let cell:Cell = row[x]
                if cell.isLive == true && cell.numberOfLiveNeighbours < 2 {
                    result.append(cell)
                }
            }
        }

        return result
    }

    func getLiveCellsWithTwoOrThreeLiveNeighbours() -> [Cell] {
        var result = [Cell]()
        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0 ..< row.count {
                let cell:Cell = row[x]
                if cell.isLive == true && (cell.numberOfLiveNeighbours == 2 || cell.numberOfLiveNeighbours == 3) {
                    result.append(cell)
                }
            }
        }

        return result
    }

    func getLiveCellsWithMoreThanThreeLiveNeighbours() -> [Cell] {
        var result = [Cell]()
        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0 ..< row.count {
                let cell:Cell = row[x]
                if cell.isLive == true && cell.numberOfLiveNeighbours > 3 {
                    result.append(cell)
                }
            }
        }

        return result
    }

    func getDeadCellsWithThreeLiveNeighbours() -> [Cell] {
        var result = [Cell]()
        for y in 0 ..< grid.count {

            let row:[Cell] = grid[y]

            for x in 0 ..< row.count {
                let cell:Cell = row[x]
                if cell.isLive == false && cell.numberOfLiveNeighbours == 3 {
                    result.append(cell)
                }
            }
        }

        return result
    }
}
