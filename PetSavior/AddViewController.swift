//
//  AddViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import SVProgressHUD

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var latitude : String?
    
    var longitude : String?
    
    var image : UIImage?
    
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
    
    override dynamic func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)               {
        self.view.endEditing(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("received location info")
        let userLocation:CLLocation = locations[0]
        self.latitude = String(format:"%lf", arguments:[userLocation.coordinate.latitude])
        self.longitude = String(format:"%lf", arguments:[userLocation.coordinate.longitude])
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
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func post(){
        if  let latitude = self.latitude,
            let longitude = self.longitude,
            let title = self.titleTextField.text,
            let description = self.descriptionTextView.text, !title.isEmpty, !description.isEmpty{
            
            SVProgressHUD.show()
            let params : [String : String] = ["latitude": latitude, "longitude" : longitude, "title" : title, "description" : description]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if let imageData = UIImageJPEGRepresentation(self.image!, 0.3) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/png")
                }
                
                for (key, value) in params{
                    if let data = value.data(using: String.Encoding.utf8){
                        multipartFormData.append(data, withName: key)
                    }
                }
                
            }, to: "http://centos.aci.k12.tr/posts", encodingCompletion: { (encodingCompletion) in
                switch encodingCompletion {
                case .success(let upload, _, _):
                    
                    upload.response(completionHandler: { (result) in
                        SVProgressHUD.dismiss()
                        if let error = result.error{
                            // error
                            print(error)
                        }else{
                            // succeeded
                            print(result.response!)
                            if result.data != nil{
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    })
                case .failure(_):
                    break
                }
            })
        }
        
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
