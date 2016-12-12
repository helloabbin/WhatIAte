//
//  WIAImagePickerController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 12/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAImagePickerController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pickerCollectionView: UICollectionView!
    
    var allPhotos: PHFetchResult<PHAsset>!
    
    fileprivate let imageManager = PHCachingImageManager()
    fileprivate var thumbnailSize: CGSize!
    fileprivate var cellSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.shared().register(self)
        
        let scale = UIScreen.main.scale
        var cellWidth :CGFloat
        let screenWidth = UIScreen.main.bounds.size.width
        
        if screenWidth >= 375.0 { // 4.7" screen or bigger
            cellWidth = (screenWidth/4) - 2.5
        }
        else {
            cellWidth = (screenWidth/3) - 2.7
        }
        
        cellSize = CGSize.init(width: cellWidth, height: cellWidth)
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        pickerCollectionView.reloadData()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func launchCamera(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Camera", bundle: nil)
        let controller : CameraViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        controller.numberOfPhotosToTake = 3
        present(controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = allPhotos.object(at: indexPath.item)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WIAImagePickerCollectionViewCell.self), for: indexPath) as? WIAImagePickerCollectionViewCell
            else { fatalError("unexpected cell in collection view") }
        
        let options = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.fast
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.opportunistic
        options.version = PHImageRequestOptionsVersion.current
        options.isSynchronous = false
        
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: options, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.thumbnailImage = image
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

}

extension WIAImagePickerController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: allPhotos)
            else { return }
        
        DispatchQueue.main.sync {
            allPhotos = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                
                guard let collectionView = self.pickerCollectionView else { fatalError() }
                collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes, removed.count > 0 {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, inserted.count > 0 {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                        
                        for asset in changes.insertedObjects {
                            let resource : PHAssetResource = PHAssetResource.assetResources(for: asset).first!
                            print(resource.originalFilename)
                        }
                        
                    }
                    if let changed = changes.changedIndexes, changed.count > 0 {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                pickerCollectionView!.reloadData()
            }
        }
    }
}
