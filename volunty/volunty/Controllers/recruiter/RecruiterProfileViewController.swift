//
//  RecruiterProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON
class RecruiterProfileViewController: UIViewController{
   
    

    //var
    
    //widgets
    
    @IBOutlet weak var myview2: UIView!
    @IBOutlet weak var myview1: UIView!
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.layer.cornerRadius = 20.0
        myview1.layer.cornerRadius = 20.0
        myview2.layer.cornerRadius = 20.0
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
       
        let defaults = UserDefaults.standard
        let recruiteriD = defaults.value(forKey: "recruiterId") as! String
        PostingViewModel.instance.fetchRecruiter(recruiterId: recruiteriD){
            result in
            switch result {
            case .success(let json ):
                    let json1 = JSON(json)
                print (json1["user"][0]["email"])
                let nameValue = json1["user"][0]["name"].string
                let emailValue = json1["user"][0]["email"].string
                let companyValue = json1["user"][0]["organisation"].string
                let phoneValue =  json1["user"][0]["phone"].string
                let image = json1["user"][0]["photo"].string
                ImageLoader.shared.loadImage(
                 identifier: image!,
                    url: "http://localhost:3000/img/\(image!)",
                    completion: { image in
                        self.imageview.image = image!
                        
                    })
                self.name.text = nameValue!
                self.email.text = emailValue!
                self.company.text = companyValue!
                self.phone.text = phoneValue!
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    @IBAction func ediitt(_ sender: Any) {
        
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        self.viewDidLoad()
    }
    @IBAction func edit(_ sender: Any) {
        print("triggered")
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    
    
  

}
