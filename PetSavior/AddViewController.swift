//
//  AddViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
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
    }

}
