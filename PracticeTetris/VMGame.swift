//
//  VMGame.swift
//  PracticeTetris
//
//  Created by Xavier Lian on 10/15/18.
//  Copyright © 2018 Xavier Lian. All rights reserved.
//

import UIKit

class VMGame: NSObject
{
    //MARK: Properties
    
    var cells = [Bool]()
    
    //MARK: Private Properties
    
    private let CELLID = "grid cell id lol"
    private let gridSize = CGSize(width: 10, height: 22)
    private var gridTotal: Int {return Int(gridSize.width * gridSize.height)}
    private weak var cv: UICollectionView?
    private let currentTetrimino = BlockL()

    //MARK: Init Stuff
    
    init(cv: UICollectionView)
    {
        super.init()
        for _ in 0 ..< gridTotal
        {
            cells.append(false)
        }
        setup(cv)
        
        let lblock = BlockL()
        lblock.draw(self)
        
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { [weak self] (time) in
            self?.dropOneCoord()
        }
    }
    
    //MARK: Functions
    
    func dropOneCoord()
    {
        for x in 0 ..< cells.count
        {
            cells[x] = false
        }
        currentTetrimino.location.y -= 1
        currentTetrimino.draw(self)
        cv?.reloadData()
    }
    
    func activate(x: Int, y: Int)
    {
        //Patterns
        //0, 0 = 210
        //1, 0 = 211
        //2, 0 = 212
        //...
        //9, 0 = 219
        
        //0, 1 = 200
        //9, 1 = 209
        
        //0, 21 = 0
        //9, 21 = 9
        
        //ycoord determines 10s
        //xcoord determines 1s
        
        var cellToColor: Int
        var xCorrection = 0
        var yCorrection = 0
        
        //Correct x bounds
        if x < 0
        {
            xCorrection = 0
        }
        else if x > 9
        {
            xCorrection = 9
        }
        else
        {
            xCorrection = x
        }
        //Correct y bounds
        if y < 0
        {
            yCorrection = 0
        }
        else if y > 21
        {
            yCorrection = 21
        }
        else
        {
            yCorrection = y
        }
        //Calculate coords
        cellToColor = 210 - yCorrection * 10
        cellToColor += xCorrection
        cells[cellToColor] = true
        cv?.reloadData()
    }
    
    func deactivate(x: Int, y: Int)
    {
        
    }
    
    //MARK: Private Functions
    
    private func setup(_ cv: UICollectionView)
    {
        self.cv = cv
        if let flowLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout
        {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
        }
        cv.dataSource = self
        cv.delegate = self
        cv.register(UINib(nibName: String(describing: CVGridCellCollectionViewCell.self),
                          bundle: nil), forCellWithReuseIdentifier: CELLID)
    }
}

extension VMGame: UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return Int(gridSize.width * gridSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CELLID, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath)
    {
        if let casted = cell as? CVGridCellCollectionViewCell,
            0 ..< cells.count ~= indexPath.item
        {
            if cells[indexPath.item]
            {
                casted.activate()
            }
            else
            {
                casted.deactivate()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width / 10,
                      height: collectionView.bounds.height / 22)
    }
}
