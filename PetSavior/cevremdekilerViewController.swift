//
//  cevremdekilerViewController.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class cevremdekilerViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate{
    
    let manager = CLLocationManager()
    
    let cellReuseIdentifier = "postCell"
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func unwindToNearby(segue:UIStoryboardSegue) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
//        manager.delegate = self
//        manager.requestLocation()
    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0]
//        let longitude = userLocation.coordinate.longitude
//        let latitude = userLocation.coordinate.latitude
//        Alamofire.request("http://api.petsavior.com/posts/nearby", method: .get, parameters: ["longitude" :longitude, "latitude": latitude, "range": "1"]).responseJSON { (response) in
//            
//        }
//    }
//   
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:postTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postTableViewCell
        // set the text from the data model
        //cell.textLabel?.text = self.x[indexPath.row]
        cell.cellLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "postCell" {
                _ = (segue.destination as! UINavigationController).viewControllers[0] as! animalDetailViewController
        }
    }
    
}
