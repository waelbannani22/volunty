//
//  HomeVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit

class HomeVolunteerViewController: UIViewController {

    var email : String?
    var name :String?
    var json : String?
    var token :String?
    var user :NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.layer.borderColor = UIColor.black.cgColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        print(email)
        let username = (  user! as NSDictionary).value(forKey: "username") as! String
        nameLabel.text = username
       // emailLabel.text = email! ?? ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "VolunteerProfileViewController") as! VolunteerProfileViewController
        
        objSomeViewController.user = user!
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBAction func edit(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "VolunteerProfileViewController") as! VolunteerProfileViewController
        
        objSomeViewController.user = user!
        print(user)

        
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
    }
    
}
