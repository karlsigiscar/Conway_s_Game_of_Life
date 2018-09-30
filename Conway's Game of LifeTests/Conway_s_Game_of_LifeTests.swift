//
//  Conway_s_Game_of_LifeTests.swift
//  Conway's Game of LifeTests
//
//  Created by Karl Sigiscar on 28/09/2018.
//  Copyright © 2018 Karl Sigiscar. All rights reserved.
//

import XCTest
@testable import Conway_s_Game_of_Life

class Conway_s_Game_of_LifeTests: XCTestCase {

    var game:ConwayGameOfLife!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = ConwayGameOfLife(width:100, height:100)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_any_live_cell_with_fewer_than_two_live_neighbors_dies_as_if_by_under_population() {
        let liveCell = game.getLiveCellsWithFewerThanTwoLiveNeighbours().first
        game.tick()
        if let isLive = liveCell?.isLive {
            XCTAssertFalse(isLive)
        } else {
            XCTFail()
        }
    }

    func test_any_live_cell_with_two_or_three_live_neighbors_lives_on_to_the_next_generation() {
        let liveCell = game.getLiveCellsWithTwoOrThreeLiveNeighbours().first
        game.tick()
        if let isLive = liveCell?.isLive {
            XCTAssertTrue(isLive)
        } else {
            XCTFail()
        }
    }

    func test_any_live_cell_with_more_than_three_live_neighbors_dies_as_if_by_overpopulation() {
        let liveCell = game.getLiveCellsWithMoreThanThreeLiveNeighbours().first
        game.tick()
        if let isLive = liveCell?.isLive {
            XCTAssertFalse(isLive)
        } else {
            XCTFail()
        }
    }

    func test_any_dead_cell_with_exactly_three_live_neighbors_becomes_a_live_cell_as_if_by_reproduction() {
        let deadCell = game.getDeadCellsWithThreeLiveNeighbours().first
        game.tick()
        if let isLive = deadCell?.isLive {
            XCTAssertTrue(isLive)
        } else {
            XCTFail()
        }
    }
}
