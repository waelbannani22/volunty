//
//  VolunteerProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit
import FacebookLogin
import FacebookCore
import SwiftyJSON

class VolunteerProfileViewController: UIViewController ,LoginButtonDelegate{
    
    //widgets
    
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var phonelabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var lastnamelabel: UILabel!
    @IBOutlet weak var firstnamelabel: UILabel!
    var user :JSON?
    var token:String?
    var id :String?
    var email :String?
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        LoginManager().logOut()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "cnxfb") as? String == Optional(nil){
            id = defaults.value(forKey: "noncnxfb") as? String
        }else {
            id = defaults.value(forKey: "cnxfb") as? String
        }
        
        HomeVolunteer.instance.fetchbyUser(id: id!){
            result in
            switch result {
            case .success(let json):
                let json2 = JSON(json!)
                self.user = json2
                print("json2",json2)
                self.email = json2["users"]["email"].string
                let token = json2["users"]["token"].string
               
                
               
                
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
   
       
       
        HomeVolunteer.instance.callingFetchHome(email: id!){
            result in
            switch result{
            case .success(let json):
                let userResponse = (  json as AnyObject).value(forKey: "username") as! String
                let lastname = (  json as AnyObject).value(forKey: "lastname") as! String
               // let date = (  json as AnyObject).value(forKey: "memberDate") as! String
                let email1 = (  json as AnyObject).value(forKey: "email") as! String
                let status = (  json as AnyObject).value(forKey: "fbUser") as? Bool
                if status == true {
                    self.reset.isEnabled = false 
                }
                self.firstnamelabel.text = userResponse
                self.lastnamelabel.text = lastname
              //  self.datelabel.text = date
                self.emaillabel.text = email1
                self.id = (  json as AnyObject).value(forKey: "_id") as? String
                self.token = (  json as AnyObject).value(forKey: "token") as? String
              //  print(token)
            case .failure(let json):
                print("error")
                
            }
        }
        
        //afectation
        
       

        
    }
    func fetch(){
        
    }
    
    @IBAction func resetpassword(_ sender: Any) {
        let email = user!["users"]["email"].string
        print (email)
        HomeVolunteer.instance.resetpassword(email: email!){
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
        resetDefaults()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.tabBarController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
        
    }
    
    @IBAction func editProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "VolunteerEditProfileViewController") as! VolunteerEditProfileViewController
       // let id = (  user! as NSDictionary).value(forKey: "_id") as! String
       // let token = (  user! as NSDictionary).value(forKey: "token") as! String
        objSomeViewController.id = self.id
        print(self.token)
        objSomeViewController.token = self.token
        print(self.id)

        
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
    }
    
    @IBAction func notifications(_ sender: Any) {
        performSegue(withIdentifier: "noti", sender: Any?.self)
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    

}
