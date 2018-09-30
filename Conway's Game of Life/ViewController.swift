//
//  ViewController.swift
//  Conway's Game of Life
//
//  Created by Karl Sigiscar on 28/09/2018.
//  Copyright © 2018 Karl Sigiscar. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    @IBOutlet weak var gameView: ConwayGameView!

    let viewModel:ViewModel = ViewModel()

    override func viewDidLoad() {
    super.viewDidLoad()
        gameView.game = viewModel.game
    }
}
