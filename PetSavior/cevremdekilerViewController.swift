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
import SwiftyJSON
import SDWebImage

class cevremdekilerViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate{
    var resp : JSON?
    
    let manager = CLLocationManager()
    
    let cellReuseIdentifier = "postCell"
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func unwindToNearby(segue:UIStoryboardSegue) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    // MARK: - CLLocationManager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("received location info")
        let userLocation:CLLocation = locations[0]
        let longitude = userLocation.coordinate.longitude
        let latitude = userLocation.coordinate.latitude
        Alamofire.request("http://petsavior.gokhanakkurt.com/posts/nearby", method: .get, parameters: ["longitude" : longitude, "latitude": latitude, "range": 2]).responseJSON { (result) in
            if let data = result.data{
                self.resp = JSON(data)
                self.tableView.reloadData()
                print("response \(self.resp)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed location info")
    }
   
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = self.resp {
            return response["result"].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:postTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postTableViewCell
        // set the text from the data model
        if let data = self.resp?["result"][indexPath.row]{
            cell.cellLabel?.text = data["title"].stringValue
            cell.cellImageView.sd_setImage(with: URL(string: data["image"].stringValue))
        }
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
