//
//  LoginViewController.swift
//  volunty
//
//  Created by wael bannani on 5/11/2021.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Alamofire


class LoginViewController: UIViewController ,UITextFieldDelegate ,LoginButtonDelegate{
    
   
   
    

    //widgets
    @IBOutlet weak var emailTextFiield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginbutton: FBLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current,
                !token.isExpired {
            print(token)
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email , name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler : { connection,result,error in
                print("result\(result!)")
                let info = result as! [String : AnyObject]
                 let name = info["name"] as? String
                 let email = info["email"] as? String
                print (info)
            
            
                let array = [name , email]
                print (array)
                
                 
                
                self.performSegue(withIdentifier: "HomeSegue", sender: array)
                
            })
         
            
        }else {
           // let loginButton = FBLoginButton()
            //loginButton.delegate = self
              //      loginButton.center = view.center
                //    view.addSubview(loginButton)
            
            loginbutton.permissions = ["public_profile", "email"]
            self.tabBarController?.navigationItem.hidesBackButton = true
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.hideKeyboardWhenTappedAround()
            emailTextFiield.delegate = self
           // emailTextFiield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            passwordTextField.delegate = self
          //  passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            indicatorStart(false)
            signInButton.isEnabled = true
            signInButton.alpha = 0.65
            let list2 = [emailTextFiield.text,passwordTextField.text]
            print(list2)
            if let token = AccessToken.current,
                    token.isExpired {
          //  self.performSegue(withIdentifier: "HomeSegue", sender: list2)
            }
            
        }
       
       
        
       
    }
    
    func loginButton(_ loginbutton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields" : "email , name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler : { connection,result,error in
        
           // let List = result!.map{$0.count}
            print("\(result!)")
            
            if ((result) != nil){
                print("result\(result!)")
                let info = result as! [String : AnyObject]
                 let name = info["name"] as? String
                 let email = info["email"] as? String
                print (info)
                let list = info.map{$0.value}
                print (list[0])
                let array = [name , email]
                self.performSegue(withIdentifier: "HomeSegue", sender: array)
                
                
            }
            
        })
    }
    
    func loginButtonDidLogOut(_ loginbutton: FBLoginButton) {
        LoginManager().logOut()
    }
  
    
    
    

    
    @objc func textFieldDidChange(textField: UITextField){
        if checkingUserInfo(){
            signInButton.isEnabled = true
            signInButton.alpha = 1.0
        }else{
            signInButton.isEnabled = false
            signInButton.alpha = 0.65
        }
    }
    func indicatorStart(_ start: Bool){
        if start{
            indicator.isHidden = false
            indicator.startAnimating()
            signInButton.isEnabled = false
            signInButton.alpha = 0.65
        }else{
            indicator.isHidden = true
            indicator.stopAnimating()
            signInButton.isEnabled = true
            signInButton.alpha = 1.0
        }
    }
    func checkingUserInfo() -> Bool{
        if emailTextFiield.text!.isValidEmail() && (passwordTextField.text?.count)! >= 3 {
            return true
        }
        return false
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if (checkingUserInfo()){
            guard let email = emailTextFiield.text else {return}
            guard let password = passwordTextField.text else {return}
            let para :[String: Any] = [
                "email":email,
                "password":password
            ]
            LoginViewModel1.instance.callingLoginAPI(email: email, password: password){
                (result)in
                switch result{
                case .success(let json):
                    let jsonSent = json!
                    debugPrint(json)
                    let token = (json as AnyObject).value(forKey: "token") as! String?
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    //print(defaults.string(forKey: "jsonwebtoken"))
                    let user = (json as AnyObject).value(forKey: "user") as! NSDictionary
                    let username = (  user as NSDictionary).value(forKey: "username") as! String
                 
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVolunteerViewController") as! HomeVolunteerViewController
                    objSomeViewController.email = email
                    objSomeViewController.token = token
                    objSomeViewController.user = user

                    
                    self.navigationController?.pushViewController(objSomeViewController, animated: true)
                   
                       
                case .failure(let json):
                   // print(err.localizedDescription)
                    print(json)
                    let alert = UIAlertController(title: "failed", message: "incorrect password or email", preferredStyle: .alert)
                    let action = UIAlertAction(title: "retry", style: .cancel, handler:nil)
                               alert.addAction(action)
                               self.present(alert,animated: true)
                    self.emailTextFiield.text?.removeAll()
                    self.passwordTextField.text?.removeAll()
                }
                
            }
        }else{
            let alert = UIAlertController(title: "failed", message: "authentification failed", preferredStyle: .alert)
                       let action = UIAlertAction(title: "retry", style: .cancel, handler: nil)
                       alert.addAction(action)
                       self.present(alert,animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "Segue1"{
                let l = sender as! [String?]
                print(l)
                if let vc = segue.destination as? HomeVolunteerViewController {
                    vc.email = l[0]
                    vc.token = l[1]
                   
                }
                
               
            }
            if segue.identifier == "HomeSegue2"{
                let v = segue.destination as? HomeVolunteerViewController
            }
            
        }
   
}
        
        
        
        
    
    
    
 
    
                           
                        
                            
                        
                    
               
    

  



