//
//  WIARatingTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIARatingTableViewCellDelegate {
    
    func WIARatingTableViewCellDidChangeRating(cell: WIARatingTableViewCell, rating: Double, indexPath: IndexPath)
    
}

class WIARatingTableViewCell: UITableViewCell {

    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var fiveView: UIView!
    @IBOutlet weak var sixView: UIView!
    @IBOutlet weak var sevenView: UIView!
    @IBOutlet weak var eightView: UIView!
    @IBOutlet weak var nineView: UIView!
    @IBOutlet weak var tenView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var cellIndexPath: IndexPath!
    var delegate: WIARatingTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panView.addGestureRecognizer(gestureRecognizer)
        
        let tapgestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        panView.addGestureRecognizer(tapgestureRecognizer)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBAction
    
    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.location(in: panView)
            updateView(value: (translation.x / panView.frame.size.width) * 10)
        }
    }
    
    @IBAction func handleTap(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let translation = gestureRecognizer.location(in: panView)
            updateView(value: (translation.x / panView.frame.size.width) * 10)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Other Methods
    
    func updateView(value : CGFloat) {
        if value > 9 {
            tenView.backgroundColor = WIAColor.colorFor(Value: value)
            nineView.backgroundColor = WIAColor.colorFor(Value: 9)
            eightView.backgroundColor = WIAColor.colorFor(Value: 8)
            sevenView.backgroundColor = WIAColor.colorFor(Value: 7)
            sixView.backgroundColor = WIAColor.colorFor(Value: 6)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "5.0"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 5.0, indexPath: cellIndexPath)
        }
        else if value > 8 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = WIAColor.colorFor(Value: 9)
            eightView.backgroundColor = WIAColor.colorFor(Value: 8)
            sevenView.backgroundColor = WIAColor.colorFor(Value: 7)
            sixView.backgroundColor = WIAColor.colorFor(Value: 6)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "4.5"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 4.5, indexPath: cellIndexPath)
        }
        else if value > 7 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = WIAColor.colorFor(Value: 8)
            sevenView.backgroundColor = WIAColor.colorFor(Value: 7)
            sixView.backgroundColor = WIAColor.colorFor(Value: 6)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "4.0"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 4.0, indexPath: cellIndexPath)
        }
        else if value > 6 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = WIAColor.colorFor(Value: 7)
            sixView.backgroundColor = WIAColor.colorFor(Value: 6)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "3.5"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 3.5, indexPath: cellIndexPath)
        }
        else if value > 5 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = WIAColor.colorFor(Value: 6)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "3.0"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 3.0, indexPath: cellIndexPath)
        }
        else if value > 4 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fiveView.backgroundColor = WIAColor.colorFor(Value: 5)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "2.5"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 2.5, indexPath: cellIndexPath)
        }
        else if value > 3 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fiveView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fourView.backgroundColor = WIAColor.colorFor(Value: 4)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "2.0"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 2.0, indexPath: cellIndexPath)
        }
        else if value > 2 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fiveView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fourView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            threeView.backgroundColor = WIAColor.colorFor(Value: 3)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "1.5"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 1.5, indexPath: cellIndexPath)
        }
        else if value > 1 {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fiveView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fourView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            threeView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            twoView.backgroundColor = WIAColor.colorFor(Value: 2)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "1.0"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 1.0, indexPath: cellIndexPath)
        }
        else {
            tenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            nineView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            eightView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sevenView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            sixView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fiveView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            fourView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            threeView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            twoView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            oneView.backgroundColor = WIAColor.colorFor(Value: 1)
            ratingLabel.text = "0.5"
            delegate?.WIARatingTableViewCellDidChangeRating(cell: self, rating: 0.5, indexPath: cellIndexPath)
        }
    }

}
