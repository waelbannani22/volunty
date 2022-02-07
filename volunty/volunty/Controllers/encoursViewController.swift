//
//  encoursViewController.swift
//  volunty
//
//  Created by wael bannani on 28/12/2021.
//

import UIKit
import SwiftyJSON
class encoursViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
 
    //var
    var size = 0
    //widgets
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let id = defaults.value(forKey: "volunteerId") as? String
        HomeVolunteer.instance.fetchEncours(idV: id! ){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                self.size = json1["user"].count
                self.tv.reloadData()
            case .failure(let value):
                print(value.localizedDescription)
            }
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let conent = cell?.contentView
        var imagetable = conent?.viewWithTag(1) as? UIImageView
        let nametable = conent?.viewWithTag(2) as? UILabel
        
        //fetch status
        let defaults = UserDefaults.standard
        let id = defaults.value(forKey: "volunteerId") as? String
        HomeVolunteer.instance.fetchEncours(idV: id! ){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                let idc = json1["user"][indexPath.row]["callId"].string
                let status = json1["user"][indexPath.row]["status"].string
                switch status {
                case "accepted" : conent?.backgroundColor = UIColor.green
                case "pending" : conent?.backgroundColor = UIColor.orange
                case "declined" : conent?.backgroundColor = UIColor.red
                case .none:
                    print("none")
                case .some(_):
                    print("some")
                    
                }
                PostingViewModel.instance.fetchbycall(callId: idc!){
                    result in
                    switch result{
                    case .success(let json2):
                        let js = JSON(json2)
                        let name = js["call"][0]["name"].string
                        nametable?.text = name!
                        let img = js["call"][0]["photo"].string
                        print(img)
                        if img != Optional(nil){
                            ImageLoader.shared.loadImage(
                             identifier: img!,
                                url: "http://localhost:8885/img/\(img!)",
                                completion: { image in
                                    imagetable?.image = image!
                                    
                                })
                        }
                    case .failure(let val):
                        print(val.localizedDescription)
                    }
                }
               
                
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        
        
        return cell!
    }

    

}
