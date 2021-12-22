//
//  resetpasswordRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 21/12/2021.
//

import UIKit

class resetpasswordRecruiterViewController: UIViewController {

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirm.isSecureTextEntry = true
        password.isSecureTextEntry = true
        
        
    }
    
    @IBAction func submittapped(_ sender: Any) {
        print(password.text!)
        if password.text != confirm.text {
            let alert = UIAlertController(title: "confirmation", message: "passwords doesn't match", preferredStyle: .alert)
            let action = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
            
        }else{
            let defaults = UserDefaults.standard
            let recruiteriD = defaults.value(forKey: "recruiterId") as! String
            let password = confirm.text!
            PostingViewModel.instance.resetpassword2(user: recruiteriD, password: password){
                result in
                switch result {
                    case .success(let json):
                        print(json!)
                        let alert = UIAlertController(title: "confirmation", message: "password has been changed", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default){
                        action -> Void in
                        self.dismiss(animated: true, completion: nil)
                    }
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    
                    case .failure(let json):
                    let alert = UIAlertController(title: "confirmation", message: "password has been changed", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default){
                    action -> Void in
                    self.dismiss(animated: true, completion: nil)
                }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    
                }
                
            }
        }
    }
    

}
