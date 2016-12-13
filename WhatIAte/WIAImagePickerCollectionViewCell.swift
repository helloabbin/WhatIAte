//
//  WIAImagePickerCollectionViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 12/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAImagePickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var selectionView: UIView!
    
    var representedAssetIdentifier: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionButton.backgroundColor = WIAColor.mainColor
    }
    
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func selectCell() {
        selectionView.alpha = 1
        selectionButton.alpha = 1
    }
    
    func deSelectCell() {
        selectionView.alpha = 0
        selectionButton.alpha = 0
    }
}
