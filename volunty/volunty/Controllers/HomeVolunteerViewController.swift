//
//  HomeVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit
import SwiftyJSON
class HomeVolunteerViewController: UIViewController {

   
 //   var name :String?
    //var json : String?
 //   var token :String?
   // var user :NSDictionary?
    var id : String? 
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.layer.borderColor = UIColor.black.cgColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        //envoie profile
        
     //   print(email)
     //   let username = (  user! as NSDictionary).value(forKey: "username") as! String
       // defaults.setValue((  user! as NSDictionary).value(forKey: "_id") as! String, forKey: "iduser")
     //   nameLabel.text = username
       // emailLabel.text = email! ?? ""
        if  defaults.value(forKey: "noncnxfb") as? String == Optional(nil){
            id = (defaults.value(forKey: "cnxfb") ) as? String
        }else{
            id =  defaults.value(forKey: "noncnxfb") as? String
        }
        print(id)
     /*   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "VolunteerProfileViewController") as! VolunteerProfileViewController
            objSomeViewController.id = id! */
        HomeVolunteer.instance.fetchbyUser(id: id!){
            result in
            switch result {
            case .success(let json):
                let json2 = JSON(json!)
                print(json2)
                let username = json2["users"]["username"].string
                defaults.setValue(self.id!, forKey: "volunteerId")
                let defaults = UserDefaults.standard
                self.nameLabel.text = username
                defaults.setValue(username, forKey: "usernamev")
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        

    }
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBAction func edit(_ sender: Any) {
        
                self.performSegue(withIdentifier: "edit", sender: self.id!)
                
               
                
         
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"
        {
            let l = sender as! String?
            if let vc = segue.destination as? VolunteerProfileViewController {
                vc.id = l!
               
            }
        }
    }
    
}
