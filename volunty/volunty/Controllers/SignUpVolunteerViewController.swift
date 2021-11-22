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
    
    
    
    @IBAction func signupTapped(_ sender: Any) {
        let params = [
            "username" : usernameText.text!,
            "lastname" : lastnameText.text!,
            "email" : emailText.text!,
            "password" : passwordText.text!
        ]
        let parameters: [String: AnyObject] = [
            "username" : usernameText.text as AnyObject,
            "lastname" : lastnameText.text as AnyObject,
            "email" : emailText.text as AnyObject,
            "password" : passwordText.text as AnyObject,
        ]
        print(parameters)
        Alamofire.request("http://localhost:3000/Signup",method : .post,parameters: parameters).responseJSON{ response in
            
            debugPrint(response)
            
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

   

}
