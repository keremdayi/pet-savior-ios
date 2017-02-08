//
//  AddViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class AddViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var latitude : Any?
    var longitude : Any?
    var image : Any?
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.cornerRadius = 5.0
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("received location info")
        let userLocation:CLLocation = locations[0]
        let longitude = userLocation.coordinate.longitude
        let latitude = userLocation.coordinate.latitude
        self.latitude = latitude
        self.longitude = longitude
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed location info")
    }
    @IBAction func photoButton(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            self.image = imagePicker
        }
    }
    @IBAction func post(){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let imageData = UIImageJPEGRepresentation(self.image as! UIImage, 0.5) {
                multipartFormData.append(imageData, withName: "file", fileName: "image", mimeType: "image/png")
            }
            
            for (key, value) in ["latitude": self.latitude,"longitude" : self.longitude, "title" : self.titleTextField.text, "description" : self.descriptionTextView.text] {
//                if let data = value.data(using: String.Encoding.utf8){
//                    multipartFormData.append(data, withName: key)
//                }
            }
            
        }, to: "http://petsavior.gokhanakkurt.com/posts", encodingCompletion: { (encodingCompletion) in
            switch encodingCompletion {
            case .success(let upload, _, _):
                
                upload.response(completionHandler: { (result) in
                    if let anError = result.error{
                        
                    }else{
                        
                    }
                })
            case .failure(_):
                break
            }
        })
    }
}
