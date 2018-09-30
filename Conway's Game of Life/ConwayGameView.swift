//
// Created by Karl Sigiscar on 30/09/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import AppKit

class ConwayGameView : NSView, Tickable {

    var game:ConwayGameOfLife! {
        didSet {
            cellWidth = self.frame.width / CGFloat(game.gridWidth)
            cellHeight = self.frame.height / CGFloat(game.gridHeight)
        }
    }
    private var cellWidth:CGFloat!
    private var cellHeight:CGFloat!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(tick), name: .tick, object: nil)
    }
    
    @objc func tick() {
        setNeedsDisplay(self.frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        for y in 0 ..< game.grid.count {
            
            let row:[Cell] = game.grid[y]
            
            for x in 0..<row.count {
                let cell: Cell = row[x]
                
                var color:NSColor
                if cell.isLive {
                    color = NSColor(named: "Alive", bundle: Bundle.main) ?? NSColor.black
                } else {
                    color = NSColor(named: "Dead", bundle: Bundle.main) ?? NSColor.white
                }
                
                color.setFill()
                let left = CGFloat(x) * cellWidth
                let top = CGFloat(y) * cellHeight
                let rect = NSRect(x: left, y: top, width: cellWidth, height: cellHeight)
                let path = NSBezierPath(rect: rect)
                path.fill()
            }
        }
    }
}

extension Notification.Name {
    static let tick = Notification.Name(
        rawValue: "tick")
}
