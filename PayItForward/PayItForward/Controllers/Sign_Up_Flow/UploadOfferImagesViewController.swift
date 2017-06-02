//
//  UploadOfferImagesViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 6/1/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseStorage

class UploadOfferImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let imagePickerController = UIImagePickerController()
    var chosenImage: UIImage!
    
    @IBOutlet weak var chosenImagesCollectionView: UICollectionView!
    
    @IBAction func choseImages(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (action) in
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let photoLibAction = UIAlertAction(title: "Choose existing photo", style: .default) { (action) in
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
    }
    
    // TODO: Import custom image picker view
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
