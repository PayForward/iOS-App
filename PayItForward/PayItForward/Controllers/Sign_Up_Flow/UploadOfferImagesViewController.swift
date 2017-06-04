//
//  UploadOfferImagesViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 6/1/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseStorage
import Photos
import DKImagePickerController
import SwiftSpinner

class UploadOfferImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var chosenImages = [UIImage]()
    
    @IBOutlet weak var chosenImagesCollectionView: UICollectionView!
    
    @IBAction func choseImages(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .actionSheet)
        
        let photoLibAction = UIAlertAction(title: "Choose existing photo", style: .default) { _ in
            let pickerController = DKImagePickerController()
            
            pickerController.didSelectAssets = { (assets: [DKAsset]) in
                for asset in assets {
                    asset.fetchOriginalImageWithCompleteBlock { (image, _) -> Void in
                        self.chosenImages.append(image!)
                    }
                }
            }
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }

        actionSheet.addAction(photoLibAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        // start spinner
        SwiftSpinner.show("Starting photo upload.")
        
        let storagePath = "\(User.shared.uid)_\(User.shared.firstName)_\(User.shared.lastName)"
        let storageRef = FIRStorage.storage().reference(withPath: storagePath)
        
        for i in 0..<self.chosenImages.count {
            let picture = UIImagePNGRepresentation(chosenImages[i])!
            
            storageRef.put(picture, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                }
                else {
                    print(metadata)
                    
                    let percentDone = Double(i / self.chosenImages.count)
                    SwiftSpinner.show(progress: percentDone, title: "Uploading photo \(i + 1) of \(self.chosenImages.count)")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.imageView.image = self.chosenImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chosenImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chosenImagesCollectionView.dataSource = self
        self.chosenImagesCollectionView.delegate = self
        
        if self.chosenImages.count == 0 {
            self.chosenImagesCollectionView.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
