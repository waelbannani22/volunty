//
//  NotificationVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON
class NotificationVolunteerViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    //var
    var size = 0
    //widgets
    var id :String?
    @IBOutlet weak var NO: UILabel!
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        
        NO.isEnabled = false
        NO.isHidden = true
        super.viewDidLoad()
        let defaults = UserDefaults.standard
       // self.navigationItem.setHidesBackButton(true, animated: true)
      //  self.tabBarController?.navigationItem.hidesBackButton = true
        if defaults.value(forKey: "cnxfb") as? String == Optional(nil){
            id = defaults.value(forKey: "noncnxfb") as? String
        }else {
            id = defaults.value(forKey: "cnxfb") as? String
        }
        print("id",id)
        HomeVolunteer.instance.fetchNotification(id: id!){
            result in
            switch result{
            case .success(let json):
                let json2 = JSON(json!)
                self.size = json2["notification"].count
                print(self.size)
                if (self.size == 0){
                    self.NO.isHidden = false
                }else{
                    self.NO.isHidden = true
                    self.tv.reloadData()
                }
                //self.tv.reloadData()
                
            case .failure(let value):
                
                print(value.localizedDescription)
            }
            
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        var date = contentView?.viewWithTag(2) as! UILabel
        var desc = contentView?.viewWithTag(1) as! UILabel
        
        //fetch api
        let defaults = UserDefaults.standard
      
        if defaults.value(forKey: "cnxfb") as? String == Optional(nil){
            self.id = defaults.value(forKey: "noncnxfb") as? String
        }else {
            self.id = defaults.value(forKey: "cnxfb") as? String
        }
        HomeVolunteer.instance.fetchNotification(id: id!){
            result in
            switch result{
            case .success(let json):
                let json2 = JSON(json!)
                //self.size = json2["notification"].count
                if (self.size == 0){
                    self.NO.isHidden = false
                }else{
                    self.NO.isHidden = true
                }
                //self.tv.reloadData()
                date.text = json2["notification"][indexPath.row]["date"].string
                desc.text = json2["notification"][indexPath.row]["contenu"].string! + json2["notification"][indexPath.row]["nameExperience"].string!
               
                
            case .failure(let value):
                
                print(value.localizedDescription)
            }
            
        }
        //self.tv.reloadData()
        return cell!
    }
    

  

}
