//
//  OpenedCallViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit
import SwiftyJSON

class OpenedCallViewController: UIViewController {

    //var
    var json : JSON?
    var id : String?
    var callvid : String?
    //wifgets
    
    @IBOutlet weak var apply: UIButton!
    
   
    @IBOutlet weak var qr: UIButton!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var gpage: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.backgroundColor = UIColor(named: "323B61")
        self.apply.isEnabled = true
        let defaults = UserDefaults.standard
        defaults.synchronize()
        print(json!)
        name.text = json!["name"].string
        date.text = json!["dateBegin"].string
        gpage.text = json!["ageGroup"].string
        desc.text = json!["description"].string
        city.text = json!["city"].string
        self.callvid = json!["_id"].string
        self.id = json!["_id"].string!
        let img = json!["photo"].string!
        ImageLoader.shared.loadImage(
         identifier: img,
            url: "http://localhost:3000/img/\(img)",
            completion: { image in
                self.imageV.image = image!
                
            })
        defaults.setValue(id, forKey: "idcallv")
//        print(defaults.value(forKey: "iduser")!)
        
    }
    
    @IBAction func qrcode(_ sender: Any) {
        let combined = "name :\(name.text!)\n date :\(date.text!)\n group age :\(gpage.text!)\n  description: \(desc.text!)\n city: \(city.text!)"
        performSegue(withIdentifier: "qr", sender:combined )
    }
    @IBAction func applyTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        
        let userid = defaults.value(forKey: "volunteerId")! as! String
        if defaults.value(forKey: "cnxfb") as? String == Optional(nil){
            self.id = defaults.value(forKey: "noncnxfb") as? String
        }else {
            self.id = defaults.value(forKey: "cnxfb") as? String
        }
       
        HomeVolunteer.instance.fetchbyUser(id: userid){
            result in
            switch result {
            case .success(let json):
                let json = JSON(json)
                let username = json["users"]["username"].string!
                
                HomeVolunteer.instance.createVolunteerCall(id: self.id!, callId: self.callvid!, username: username, lastname: json["users"]["lastname"].string!, email: json["users"]["email"].string!,  age: "" , memberDate: ""){
                    result1 in
                
                    switch result1 {
                    case .success(let json):
                        let alert = UIAlertController(title: "success", message: "your request has been submited", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert,animated: true)
                        self.apply.isEnabled = false
                    case .failure(let value):
                        let alert = UIAlertController(title: "failure", message: "your request has been  already submited", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    }
                    
                }
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        
    }
    
    @IBAction func reviews(_ sender: Any) {
        performSegue(withIdentifier: "review", sender: self.id)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "review" {
            let l = sender as! String?
            if let vc = segue.destination as? OpenedCallReviewsViewController {
                vc.id = l!
               
            }
        }
        if segue.identifier == "qr"{
            let o = sender as! String?
            if let vc1 = segue.destination as? volunteerQrViewController{
                vc1.combined = o!
            }
        }
    }
    

}
