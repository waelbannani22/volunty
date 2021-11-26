//
//  SignUpVolunteerViewController.swift
//  volunty
//
//  Created by wael bannani on 21/11/2021.
//

import UIKit
import Alamofire

class SignUpVolunteerViewController: UIViewController,UITextFieldDelegate {
    
    
    //widgets
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var lastnameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameText.delegate = self
        lastnameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        
        
        
    }
    
    
    func checkingUserInfo() -> Bool{
        if emailText.text!.isValidEmail() && (passwordText.text?.count)! >= 3 {
            return true
        }
        return false
    }
    @IBAction func signupTapped(_ sender: UIButton) {
       
       
        if (checkingUserInfo()){
            guard let email = emailText.text else {return}
            guard let password = passwordText.text else {return}
            guard let lastname = lastnameText.text else {return}
            guard let username = usernameText.text else {return}
            guard let phone = phoneText.text else {return}
            guard let age = ageText.text else {return}

            
            let params = [
                "username" : usernameText.text!,
                "lastname" : lastnameText.text!,
                "email" : emailText.text!,
                "password" : passwordText.text!
                
            ]
            
            LoginViewModel1.instance.callingSignUpAPI(email: email, password: password, username: username, lastname: lastname, age: age, phone: phone){
                (result)in
                print(result)
                
                switch result{
                 
                case .success(let json):
                    let token = (json as AnyObject).value(forKey: "user") as! NSDictionary?
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                    let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

                      // If you want to push to new ViewController then use this
                      self.navigationController?.pushViewController(objSomeViewController, animated: true)
                    print(token!)
                   
                    
                case .failure(let json):
                   // print(err.localizedDescription)
                    print(json)
                    let alert = UIAlertController(title: "failed", message: "incorrect password or email", preferredStyle: .alert)
                    let action = UIAlertAction(title: "retry", style: .cancel, handler:nil)
                               alert.addAction(action)
                               self.present(alert,animated: true)
                   // self.emailTextFiield.text?.removeAll()
                   // self.passwordTextField.text?.removeAll()
                }
                
            }
        }else{
            let alert = UIAlertController(title: "failed", message: "check your mail and your password", preferredStyle: .alert)
                       let action = UIAlertAction(title: "retry", style: .cancel, handler: nil)
                       alert.addAction(action)
                       self.present(alert,animated: true)
            emailText.text?.removeAll()
            passwordText.text?.removeAll()
        }
       
        
        
        
        
    }
        
    }
    
    //test
    func test(){
        Alamofire.request("http://localhost:3000/Volunteers").responseJSON {
            response in
            
            switch response.result{
            case .success(let data):
                if let users = data as? [[String :Any]]{
                    for user in users {
                        print("succes")
                    }
                }
            case .failure(let error):
                print("error")
                
            }
            debugPrint(response.result)
        }
    }

   


