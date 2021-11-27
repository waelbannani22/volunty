//
//  VolunteerProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit
import FacebookLogin
import FacebookCore

class VolunteerProfileViewController: UIViewController ,LoginButtonDelegate{
    
    //widgets
    
    @IBOutlet weak var phonelabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var lastnamelabel: UILabel!
    @IBOutlet weak var firstnamelabel: UILabel!
    var user :NSDictionary?
  
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        LoginManager().logOut()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    // print(user)
        let email = (  user! as NSDictionary).value(forKey: "email") as! String
        let token = (  user! as NSDictionary).value(forKey: "token") as! String
        print(email,token)
        HomeVolunteer.instance.callingFetchHome(email: email, token: token){
            result in
            switch result{
            case .success(let json):
                let userResponse = (  json as AnyObject).value(forKey: "username") as! String
                let lastname = (  json as AnyObject).value(forKey: "lastname") as! String
                let date = (  json as AnyObject).value(forKey: "memberDate") as! String
                let email1 = (  json as AnyObject).value(forKey: "email") as! String
                self.firstnamelabel.text = userResponse
                self.lastnamelabel.text = lastname
                self.datelabel.text = date
                self.emaillabel.text = email1
                print(userResponse)
            case .failure(let json):
                print("error")
                
            }
        }
        
        //afectation
        
       

        
    }
    func fetch(){
        
    }
    
    @IBAction func resetpassword(_ sender: Any) {
        let email = (  user! as NSDictionary).value(forKey: "email") as! String
        print (email)
        HomeVolunteer.instance.resetpassword(email: email){
            result in
            switch result {
                case .success(let json):
                    let token = (  json as AnyObject).value(forKey: "token") as! String
                    let user = (  json as AnyObject).value(forKey: "user") as! String
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                    
                    objSomeViewController.user = user
                    objSomeViewController.token = token
                    print(user)

                    
                    self.navigationController?.pushViewController(objSomeViewController, animated: true)
                case .failure(let json):
                    print("failed to reset")
            }
        }
    }
    @IBAction func logout(_ sender: UIButton) {
        LoginManager().logOut()
    }
    
    
   

}
