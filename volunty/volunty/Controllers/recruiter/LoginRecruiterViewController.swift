//
//  LoginRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit

class LoginRecruiterViewController: UIViewController ,UITextFieldDelegate{

    
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailtf.delegate = self
        passwordtf.delegate = self
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailtf.text!
        let pass = passwordtf.text!
        if (email == "nil") || (pass == ""){
            let alert = UIAlertController(title: "alert", message: "please fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
            
        }
        else{
            LoginViewModel1.instance.callingLoginRecruiterAPI(email: email, password: pass){
                result in
                switch result {
                case .success(let json):
                    let alert = UIAlertController(title: "success", message: "connected successfully", preferredStyle: .alert)
                    let action = UIAlertAction(title: "go to home", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                case .failure(let json):
                    let alert = UIAlertController(title: "failure", message: "password invalid", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
        }
    }
    

}
