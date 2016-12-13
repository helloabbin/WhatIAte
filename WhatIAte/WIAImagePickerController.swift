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
    @IBOutlet weak var cameraItem: UIBarButtonItem!
    
    fileprivate let imageManager = PHCachingImageManager()
    
    fileprivate var selectedAssets = [PHAsset]()
    fileprivate var allPhotos: PHFetchResult<PHAsset>!
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBAction
    
    @IBAction func cancelImagePicker(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func launchCamera(_ sender: Any) {
        presentCamera(presentingViewController: self, withNumberOfPhotosToTake: 3 - selectedAssets.count)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = allPhotos.object(at: indexPath.item)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WIAImagePickerCollectionViewCell.self), for: indexPath) as? WIAImagePickerCollectionViewCell
            else { fatalError("unexpected cell in collection view") }
        
        if selectedAssets.contains(asset) {
            cell.selectCell()
        }
        else{
            cell.deSelectCell()
        }
        
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell : WIAImagePickerCollectionViewCell = collectionView.cellForItem(at: indexPath) as? WIAImagePickerCollectionViewCell
            else { fatalError("unexpected cell in collection view") }
        let asset = allPhotos.object(at: indexPath.item)
        
        if selectedAssets.contains(asset) {
            cell.deSelectCell()
            selectedAssets.remove(at: selectedAssets.index(of: asset)!)
        }
        else{
            if selectedAssets.count < 3 {
                cell.selectCell()
                selectedAssets.append(asset)
            }
        }
        
        if selectedAssets.count > 2 {
            cameraItem.isEnabled = false
        }
        else{
            cameraItem.isEnabled = true
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Extension

extension UIViewController {
    func presentImagePicker(presentingViewController : UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .authorized {
            let controller = storyboard?.instantiateViewController(withIdentifier: "WIAImagePickerController")
            presentingViewController.present(controller!, animated: true, completion: nil)
        }
        else if status == .denied {
            DispatchQueue.main.async { [unowned presentingViewController] in
                let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
                let message = "\(appName) doesn't have permission to use the Photos Library, please change privacy settings"
                let alertController = UIAlertController(title: appName, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "Settings", style: .`default`, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                }))
                
                presentingViewController.present(alertController, animated: true, completion: nil)
            }
        }
        else if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ [unowned presentingViewController] status in
                if status == .authorized {
                    DispatchQueue.main.async { [unowned presentingViewController] in
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WIAImagePickerController")
                        presentingViewController.present(controller!, animated: true, completion: nil)
                    }
                }
            })
        }
        
    }
}

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
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
                            let name : String = resource.originalFilename
                            if name[0 ..< 3] == "WIA" {
                                self.selectedAssets.append(asset)
                            }
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
