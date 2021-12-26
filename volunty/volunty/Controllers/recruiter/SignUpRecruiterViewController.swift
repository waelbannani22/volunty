//
//  SignUpRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit
import simd

class SignUpRecruiterViewController: UIViewController ,UITextFieldDelegate{

    //widgets
    @IBOutlet weak var nametf: UITextField!
    
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var signupbutton: UIButton!
    @IBOutlet weak var phonetf: UITextField!
    @IBOutlet weak var confirmpasstf: UITextField!
    @IBOutlet weak var passtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var organisationtf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.layer.cornerRadius = 20.0
        phonetf.delegate = self
        nametf.delegate = self
        emailtf.delegate = self
        passtf.delegate = self
        confirmpasstf.delegate = self
        organisationtf.delegate = self
    }
    

   
    @IBAction func signupTapped(_ sender: Any) {
        let phone = phonetf.text!
        let name = nametf.text!
        let email = emailtf.text!
        let pass = passtf.text!
        let confirm = confirmpasstf.text!
        let organisation = organisationtf.text!
        if phone == "" || name == "" || email == "" || pass == "" || confirm == "" || organisation == "" {
            let alert = UIAlertController(title: "failure", message: "please fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
            
        }else
        if pass != confirm {
            let alert = UIAlertController(title: "failure", message: "confirm password should match password", preferredStyle: .alert)
            let action = UIAlertAction(title: "retry", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else{
            LoginViewModel1.instance.callingSignUpRecruiterAPI(email: email, password: pass, name: name, description: "", organisation: organisation, phone: phone){
                result in
                print(result)
                switch result {
                case .success(let json):
                    let alert = UIAlertController(title: "success", message: "your account has been created", preferredStyle: .alert)
                    let action = UIAlertAction(title: "retry", style: .default){
                        action ->Void in
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginRecruiterViewController") as! LoginRecruiterViewController
                        
                        self.navigationController?.pushViewController(objSomeViewController, animated: true)
                        
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    
                    
                case .failure(let json):
                    let alert = UIAlertController(title: "failure", message: "invalid password or email", preferredStyle: .alert)
                    let action = UIAlertAction(title: "retry", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    
                }
            }
        }
     
    }
    
}
