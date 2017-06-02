//
//  UploadImageViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/14/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseStorage
import DKCamera
import DKImagePickerController
import Photos

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    var chosenImage: UIImage!

    @IBOutlet weak var chosenImageView: UIImageView!
    
    @IBAction func uploadImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (action) in
            let camera = DKCamera()
            
            camera.didCancel = { () in
                print("didCancel")
                
                self.dismiss(animated: true, completion: nil)
            }
            
            camera.didFinishCapturingImage = {(image: UIImage) in
                print("didFinishCapturingImage")
                print(image)
                
                self.dismiss(animated: true, completion: nil)
            }
            self.present(camera, animated: true, completion: nil)
        }
        
        let photoLibAction = UIAlertAction(title: "Choose existing photo", style: .default) { (action) in
            let pickerController = DKImagePickerController()
            
            pickerController.didSelectAssets = { (assets: [DKAsset]) in
                print("didSelectAssets")
                print(assets)
                
                let manager = PHImageManager.default()
                let options = PHImageRequestOptions()
                
                options.version = .original
                options.isSynchronous = true
                
                manager.requestImageData(for: (assets.first?.originalAsset)!, options: options) { (data, _, _, _) in
                    if let data = data {
                        self.chosenImage = UIImage(data: data)
                    }
                }
                
                if assets.count > 1 {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func store(image: UIImage) {
        let scaledImage = scale(image: self.chosenImage, toWidth: 50)!
        let prefix = "\(User.shared.firstName)\(User.shared.lastName)"
        let storageRef = FIRStorage.storage().reference().child("\(prefix)profilePicture.png")
        
        if let uploadData = UIImagePNGRepresentation(scaledImage) {
            storageRef.put(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                }
                    
                else {
                    print("Completed! \nMetadata: \(metadata)")
                    
                    self.performSegue(withIdentifier: "toTitle", sender: self)
                }
                
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.chosenImage = pickedImage
            
            let scaledImage = scale(image: pickedImage, toWidth: 200)
            self.chosenImageView.image = scaledImage
        }
        
        let scaledImage = scale(image: self.chosenImage, toWidth: 50)!
        let prefix = "\(User.shared.firstName)\(User.shared.lastName)"
        let storageRef = FIRStorage.storage().reference().child("\(prefix)profilePicture.png")
        
        if let uploadData = UIImagePNGRepresentation(scaledImage) {
            storageRef.put(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                }
                    
                else {
                    print("Completed! \nMetadata: \(metadata)")
                    
                    self.performSegue(withIdentifier: "toTitle", sender: self)
                }
                
            }
        }

        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController.delegate = self
    }

}
