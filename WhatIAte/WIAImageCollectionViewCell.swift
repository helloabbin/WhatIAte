//
//  WIAImageCollectionViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 19/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    var representedAssetIdentifier: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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


}
