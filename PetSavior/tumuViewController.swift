//
//  tumuViewController.swift
//  PetSavior
//
//  Created by kerem on 06/02/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Alamofire
import CoreLocation

class tumuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate{
    
    var resp : JSON?
    
    let manager = CLLocationManager()
    
    let cellReuseIdentifier = "postCell"
    
    var longitude : Double = 0.0
    
    var latitude : Double = 0.0
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        manager.delegate = self
        manager.requestLocation()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
    
    func fetch(){
        Alamofire.request("http://centos.aci.k12.tr/posts/nearby", method: .get, parameters: ["longitude" : self.longitude, "latitude": self.latitude, "range": 100]).responseJSON { (result) in
            if let data = result.data{
                self.resp = JSON(data)
                self.tableView.reloadData()
                print("response \(self.resp)")
            }
        }
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        fetch()
    }
    
    // MARK: - CLLocationManager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("received location info")
        let userLocation:CLLocation = locations[0]
        self.longitude = userLocation.coordinate.longitude
        self.latitude = userLocation.coordinate.latitude
        fetch()
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
        detail = self.resp?["result"][indexPath.row]
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
