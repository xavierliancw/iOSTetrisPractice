//
//  ViewController.swift
//  PracticeTetris
//
//  Created by Xavier Lian on 10/15/18.
//  Copyright © 2018 Xavier Lian. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //MARK: Private Properties
    
    private var vm: VMGame?
    
    //MARK: UI Properties

    @IBOutlet private var cv: UICollectionView!

    //MARK: UI Stuff
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        if vm == nil
        {
            vm = VMGame(cv: cv)
        }
    }
    
    //MARK: Private Functions
    
}

struct Coord
{
    var x: Int
    var y: Int
}

protocol Tetrimino
{
    var location: Coord {get set}
    var drawInstructions: [Coord] {get set}
}
extension Tetrimino
{
    func draw(_ vm: VMGame)
    {
        for coord in drawInstructions
        {
            vm.activate(x: location.x + coord.x,
                        y: location.y + coord.y)
        }
    }
}

class BlockL: Tetrimino
{
    var location: Coord = Coord(x: 5, y: 21)
    var drawInstructions: [Coord] = [Coord(x: 0, y: 0),
                                     Coord(x: 0, y: -1),
                                     Coord(x: 0, y: -2),
                                     Coord(x: 0, y: -3),
                                     Coord(x: 1, y: -3)]
}
