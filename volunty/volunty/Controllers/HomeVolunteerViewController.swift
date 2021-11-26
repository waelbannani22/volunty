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
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.layer.borderColor = UIColor.black.cgColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        
      //  nameLabel.text = name! ?? ""
       // emailLabel.text = email! ?? ""
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    

}
