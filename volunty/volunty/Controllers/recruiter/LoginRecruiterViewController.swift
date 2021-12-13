//
//  LoginRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit
import simd

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
                  
                    let token = (  json as AnyObject).value(forKey: "token") as! String
                    let user = (  json as AnyObject).value(forKey: "user") as! NSDictionary
                    let userId = (  user as AnyObject).value(forKey: "_id") as! String
                    let name = (  user as AnyObject).value(forKey: "name") as! String
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "PostingRecruiterViewController") as! PostingRecruiterViewController
                    let defaults = UserDefaults.standard
                    defaults.setValue(token, forKey: "recruitertoken")
                    defaults.setValue(userId, forKey: "recruiterId")
                    defaults.setValue(name, forKey: "name")
                    
                    objSomeViewController.token = token
                    objSomeViewController.userId = userId
                    let alert = UIAlertController(title: "success", message: "connected successfully", preferredStyle: .alert)
                   /* let action = UIAlertAction(title: "go to home", style: .default){action ->Void in
                        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "MyPostsViewController") as! MyPostsViewController
                        self.navigationController?.pushViewController(objSomeViewController, animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)*/
                    print(defaults.value(forKey: "sizeof"))
                    self.performSegue(withIdentifier: "tab", sender: nil)
                  
                    
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
