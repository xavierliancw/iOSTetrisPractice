//
//  CVGridCellCollectionViewCell.swift
//  PracticeTetris
//
//  Created by Xavier Lian on 10/15/18.
//  Copyright © 2018 Xavier Lian. All rights reserved.
//

import UIKit

class CVGridCellCollectionViewCell: UICollectionViewCell
{
    //MARK: Properties
    
    var activatedColor = UIColor.red
    var deactivatedColor = UIColor.white
    var isActivated = false
    
    //MARK: Private Properties
    
    @IBOutlet private var colorVw: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        deactivate()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        deactivate()
    }
    
    //MARK: Functions
    
    func activate()
    {
        colorVw.backgroundColor = activatedColor
    }
    
    func deactivate()
    {
        colorVw.backgroundColor = deactivatedColor
    }
}
