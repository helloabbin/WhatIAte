//
//  WIACollectionViewTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 19/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIACollectionViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let imageManager = PHCachingImageManager()
    public var selectedAssets = [PHAsset]()
    @IBOutlet weak var imageCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.register(UINib.init(nibName: "WIAImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WIAImageCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = selectedAssets[indexPath.row]
        
        let cell : WIAImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WIAImageCollectionViewCell", for: indexPath) as! WIAImageCollectionViewCell
        
        let options = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.fast
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.opportunistic
        options.version = PHImageRequestOptionsVersion.current
        options.isSynchronous = false
        
        cell.representedAssetIdentifier = asset.localIdentifier
        let scale : Int = Int(UIScreen.main.scale)
        let thumbnailSize = CGSize.init(width: (100 * asset.pixelWidth/asset.pixelHeight) * scale, height: 100 * scale)
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: options, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.thumbnailImage = image
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let asset = selectedAssets[indexPath.row]
        return CGSize.init(width: 100 * asset.pixelWidth/asset.pixelHeight, height: 100)
    }
    
}
