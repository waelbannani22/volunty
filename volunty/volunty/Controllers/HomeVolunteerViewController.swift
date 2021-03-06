//
//  HomeVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit
import SwiftyJSON
class HomeVolunteerViewController: UIViewController {

   
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var myview: UIView!
    //   var name :String?
    //var json : String?
 //   var token :String?
   // var user :NSDictionary?
    var id : String? 
    override func viewDidLoad() {
        super.viewDidLoad()
        //view corner
        
        myview.layer.cornerRadius = 10
        let defaults = UserDefaults.standard
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.layer.borderColor = UIColor.black.cgColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        //envoie profile
        PostingViewModel.instance.fetchDonationAll{
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                print(json1)
               
                let size = json1["donation"].count
                if size != 0 {
                    let img = json1["donation"][size]["photo"].string
                    if img != Optional(nil){
                        ImageLoader.shared.loadImage(
                         identifier: img!,
                            url: "http://localhost:3000/img/\(img!)",
                            completion: { image in
                                self.imagee.image = image!
                                
                            })
                    }
                }
               
               
               
                
                
                
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
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
                let img = json2["users"]["photo"].string
                if img != Optional(nil){
                    ImageLoader.shared.loadImage(
                     identifier: img!,
                        url: "http://localhost:3000/img/\(img!)",
                        completion: { image in
                            self.imageProfile.image = image!
                            
                        })
                }
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
       /* if segue.identifier == "edit"
        {
            let l = sender as! String?
            if let vc = segue.destination as? VolunteerProfileViewController {
                vc.id = l!
               
            }
        }*/
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
