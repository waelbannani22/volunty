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
import SwiftyJSON

class LoginViewController: UIViewController ,UITextFieldDelegate ,LoginButtonDelegate{
   
    
    //widgets
    @IBOutlet weak var emailTextFiield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
   
    var id :String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.hidesBottomBarWhenPushed = true
        if let token = AccessToken.current,
                !token.isExpired {
            print(token)
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email , name,picture,first_name,last_name",],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler : { connection,result,error in
                print("result\(result!)")
                let info = result as! [String : AnyObject]
                 let name = info["name"] as? String
                 let email = info["email"] as? String
                let id = info["id"] as? String
                HomeVolunteer.instance.fetchbyFB(fbid: id!){
                    res in
                    switch res {
                    case .success(let json):
                        let jsi = JSON(json)
                        let fb = jsi["user"][0]["_id"].string!
                        let defaults = UserDefaults.standard
                        defaults.setValue(fb, forKey: "cnxfb")
                        let tok = jsi["user"][0]["token"].string!
                        defaults.setValue(tok, forKey: "jsonwebtoken")
                        self.performSegue(withIdentifier: "HomeSegue", sender:nil )
                    case .failure(let value):
                        self.printContent(value.localizedDescription)
                    }
                }
               
            
            
                
               
                 
                
                //self.performSegue(withIdentifier: "HomeSegue", sender: id!)
                
            })
         
            
        }else {
            self.tabBarController?.hidesBottomBarWhenPushed = true
            let loginButton = FBLoginButton()
            loginButton.delegate = self
            
            let X_Position:CGFloat? = 100.0 //use your X position here
            var Y_Position:CGFloat? = 780.0 //use your Y position here
            loginButton.frame = CGRect(x: X_Position!, y: Y_Position!, width: loginButton.frame.width, height: loginButton.frame.height)
                    view.addSubview(loginButton)
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            self.tabBarController?.navigationItem.hidesBackButton = true
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.hideKeyboardWhenTappedAround()
            emailTextFiield.delegate = self
          
            passwordTextField.delegate = self
            //loginButton.isEnabled = true
            indicatorStart(false)
            signInButton.isEnabled = true
            signInButton.alpha = 0.65
            let list2 = [emailTextFiield.text,passwordTextField.text]
            print(list2)
            if let token = AccessToken.current,
                    !token.isExpired {
               
          //  self.performSegue(withIdentifier: "HomeSegue", sender: list2)
            }
            
        }
       
       
        
       
    }
    
   
    func loginButton(_ loginbutton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
            //, last_name ,age,about,picture"
        print("facebook buttoonn")
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields" : "email , name,picture,first_name,last_name",],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler : { connection,result,error in
        
           // let List = result!.map{$0.count}
            print("\(result!)")
            
            if ((result) != nil){
                print("resultButton\(result!)")
                let info = result as! [String : AnyObject]
                let json2 = JSON(result!)
                 let first = info["first_name"] as? String
                 let email = info["email"] as? String
                let last = info["last_name"] as? String
                let fbid = info["id"] as? String
                let picture = json2["picture"]["data"]["url"].string
                HomeVolunteer.instance.addVB(name: first!, last: last!, email: email!, picture: picture!, fbid: fbid!){
                    res in
                    switch res {
                    case .success(let json):
                        let js = JSON(json)
                        print(js)
                        self.id = js["user"]["_id"].string
                        print("iidd,",js["user"]["_id"])
                        let defaults = UserDefaults.standard
                        defaults.setValue(self.id!, forKey: "cnxfb")
                        let token = (json as AnyObject).value(forKey: "token") as! String?
                        defaults.setValue(token, forKey: "jsonwebtoken")
                        self.performSegue(withIdentifier: "HomeSegue", sender:nil )
                        
                      
                    case .failure(let value):
                        print(value.localizedDescription)
                    }
                }
              
              
                
                
            }
            
        }
        )
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
        indicatorStart(true)
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
                    self.indicatorStart(false)
                    let jsonSent = json!
                    debugPrint(json)
                    let token = (json as AnyObject).value(forKey: "token") as! String?
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    //print(defaults.string(forKey: "jsonwebtoken"))
                    let user = (json as AnyObject).value(forKey: "user") as! NSDictionary
                    let username = (  user as NSDictionary).value(forKey: "username") as! String
                 let id = (  user as NSDictionary).value(forKey: "_id") as! String
                    defaults.setValue(id, forKey: "noncnxfb")
                    print(defaults.value(forKey: "noncnxfb")as?String)
                   self.performSegue(withIdentifier: "tab", sender: nil)
                    
                    //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   // let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVolunteerViewController") as! HomeVolunteerViewController
                 //   objSomeViewController.email = email
                   // objSomeViewController.token = token
                   // objSomeViewController.user = user
                
                   // self.navigationController?.pushViewController(objSomeViewController, animated: true)
                   // self.navigationController?.pushViewController(objSomeViewController, animated: true)
                   
                       
                case .failure(let json):
                   // print(err.localizedDescription)
                    self.indicatorStart(false)

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
            indicatorStart(false)
            let alert = UIAlertController(title: "failed", message: "authentification failed", preferredStyle: .alert)
                       let action = UIAlertAction(title: "retry", style: .cancel, handler: nil)
                       alert.addAction(action)
                       self.present(alert,animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "tab"{
                //let l = sender as! String?
              //  print("id",l!)
                if let vc = segue.destination as? HomeVolunteerViewController {
                 //   vc.id = l!
                   
                }
                
               
            }
            if segue.identifier == "HomeSegue"{
              //  let d = sender as! String?
                if let v = segue.destination as? HomeVolunteerViewController{
                   // v.id = d!
                    
                }
                
            }
            
        }
   

}
        
        
        
    
    
    
 
    
                           
                        
                            
                        
                    
               
    

  



