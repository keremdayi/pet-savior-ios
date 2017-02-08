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

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var latitude : Double?
    
    var longitude : Double?
    
    var image : UIImage?
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    override dynamic func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
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
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed location info")
    }
    
    @IBAction func photoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func post(){
        // TODO: Validation required.
        print("posting...")
        let params : [String : AnyObject] = ["latitude": (self.latitude as AnyObject),"longitude" : (self.longitude as AnyObject), "title" : (self.titleTextField.text as AnyObject), "description" : (self.descriptionTextView.text as AnyObject)]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let imageData = UIImageJPEGRepresentation(self.image!, 0.5) {
                multipartFormData.append(imageData, withName: "file", fileName: "image", mimeType: "image/png")
            }
            
            for (key, value) in params{
                if let data = value.data(using: String.Encoding.utf8.rawValue){
                    multipartFormData.append(data, withName: key)
                }
            }
            
        }, to: "http://petsavior.gokhanakkurt.com/posts", encodingCompletion: { (encodingCompletion) in
            switch encodingCompletion {
            case .success(let upload, _, _):
                
                upload.response(completionHandler: { (result) in
                    if let _ = result.error{
                        // error
                    }else{
                        // succeeded
                    }
                })
            case .failure(_):
                break
            }
        })
    }
    
    //MARK: Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        print("yes")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.image = nil
        print("no")
    }
}
