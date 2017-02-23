//
//  animalDetailViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit
import MapKit
class animalDetailViewController: UIViewController {

    @IBOutlet weak var animalDetailMapView: MKMapView!
    @IBOutlet weak var animalDetailImageView: UIImageView!
    @IBOutlet weak var animalDetailTitleTextView: UITextView!
    @IBOutlet weak var animalDetailDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        animalDetailImageView.isUserInteractionEnabled = true
        animalDetailImageView.addGestureRecognizer(tapGestureRecognizer)
        super.viewDidLoad()
        self.animalDetailTitleTextView.layer.borderWidth = 1
        self.animalDetailTitleTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.animalDetailTitleTextView.layer.cornerRadius = 4
        self.animalDetailDescriptionTextView.layer.borderWidth = 1
        self.animalDetailDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.animalDetailDescriptionTextView.layer.cornerRadius = 4
        self.animalDetailTitleTextView.text = detail?["title"].stringValue
        self.animalDetailDescriptionTextView.text = detail?["description"].stringValue
        self.animalDetailImageView.sd_setImage(with: URL(string: (detail?["image"].stringValue)!))
        
        let annotation = MKPointAnnotation()
        annotation.title = detail?["title"].stringValue
        let coordinate = CLLocationCoordinate2D(latitude : (detail?["latitude"].doubleValue)!,
                                                longitude : (detail?["longitude"].doubleValue)!)
        annotation.coordinate = coordinate
        animalDetailMapView.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        // Your action
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }*/
 

}
