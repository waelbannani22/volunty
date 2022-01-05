//
//  ResetPasswordViewController.swift
//  volunty
//
//  Created by wael bannani on 27/11/2021.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    
    //widgets
    
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var confirmlabel: UITextField!
    @IBOutlet weak var newlabel: UITextField!
    //var
    var token :String?
    var user :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.layer.cornerRadius = 20.0
        print(token,user)
      
    }
    

    @IBAction func confirm(_ sender: Any) {
        if confirmlabel.text != newlabel.text {
            let alert = UIAlertController(title: "confirmation", message: "passwords doesn't match", preferredStyle: .alert)
            let action = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
            
        }else{
            let password = confirmlabel.text!
            HomeVolunteer.instance.resetpassword2(user: user!, token: token!, password: password){
                result in
                switch result {
                    case .success(let json):
                        print(json!)
                        let alert = UIAlertController(title: "confirmation", message: "password has been changed", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    case .failure(let json):
                    let alert = UIAlertController(title: "failure", message: "password hasn't been changed", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
        }
    }
    

}
