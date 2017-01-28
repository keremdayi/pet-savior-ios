//
//  animalDetailViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit

class animalDetailViewController: UIViewController {

    @IBOutlet weak var animalDetailTitleTextView: UITextView!
    @IBOutlet weak var animalDetailDescriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animalDetailTitleTextView.layer.borderWidth = 1
        self.animalDetailTitleTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.animalDetailTitleTextView.layer.cornerRadius = 4
        self.animalDetailDescriptionTextView.layer.borderWidth = 1
        self.animalDetailDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.animalDetailDescriptionTextView.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
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
