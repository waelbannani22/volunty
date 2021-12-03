//
//  GestionVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON
class GestionVolunteerViewController: UIViewController  {
//var
    var valueJson :JSON!
    var id :String?
    //widgets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var firstnamelabel: UILabel!
    
    @IBOutlet weak var declinedbuuton: UIButton!
    @IBOutlet weak var acceptbutton: UIButton!
    @IBOutlet weak var citylabel: UILabel!
    @IBOutlet weak var birthdaylabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var lastnamelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnamelabel.text = valueJson["username"].string
        lastnamelabel.text = valueJson["lastname"].string
        self.id = valueJson["idV"].string
        if (valueJson["status"].string! == "accepted" || valueJson["status"].string! == "declined" ){
            declinedbuuton.isHidden = true
            acceptbutton.isHidden =  true
        }
        

        
    }
    
    @IBAction func acceptTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        PostingViewModel.instance.accept(callId: defaults.value(forKey: "usercall1") as! String, idv: self.id!){
            result in
            switch result{
            case .success(_):
                let alert = UIAlertController(title: "success", message: "volunteer has been accepted", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                
            case .failure(let value):
                let alert = UIAlertController(title: "failure", message: value.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                
            }
        }
    }
    
    @IBAction func declineTapped(_ sender: Any) {
    }
    
  

}
