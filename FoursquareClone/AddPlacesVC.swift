//
//  AddPlacesVC.swift
//  FoursquareClone
//
//  Created by Birkan Pusa on 14.01.2022.
//

import UIKit

class AddPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //var globalName = ""
    //var globalType = ""
    //var globalDescription = ""
    
    
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeDescriptionText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //görseli tıklanabilir yapıyoruz
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
        //klavye kapama
        let hideKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardRecognizer)

    }
    
    //klavye kapama fonksiyonu
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func chooseImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    


    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeDescriptionText.text != "" {
            if let chosenImage = placeImageView.image {
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeDescription = placeDescriptionText.text!
                placeModel.placeImage = chosenImage
                
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)

        } else {
            let alert = UIAlertController(title: "Error", message: "Enter Name/Type/Description/Image", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        

        
        //globalName = placeNameText.text!
        //globalType = placeTypeText.text!
        //globalDescription = placeDescriptionText.text!
        
        
    }
    
}
