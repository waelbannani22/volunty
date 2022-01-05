//
//  VerifcodeViewController.swift
//  volunty
//
//  Created by wael bannani on 28/11/2021.
//

import UIKit

class VerifcodeViewController: UIViewController {

    @IBOutlet weak var myview2: UIView!
    @IBOutlet weak var myview1: UIView!
    @IBOutlet weak var submitpass: UIButton!
    @IBOutlet weak var confirmtf: UITextField!
    @IBOutlet weak var newtf: UITextField!
    @IBOutlet weak var submitcode: UIButton!
    @IBOutlet weak var codeltf: UITextField!
    var codePassed :String?
    var userId :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        myview1.layer.cornerRadius = 20.0
        myview2.layer.cornerRadius = 20.0
        submitpass.isEnabled = false
    }
    

    @IBAction func submitcodeTapped(_ sender: Any) {
        let codep = codePassed!
        let code = self.codeltf.text!
        print("codetapped\(code)")
        print("codepassed\(codep)")
        LoginViewModel1.instance.verifcode(codePassed: codep, code: code){
            result in
            switch result {
            case .success(let json):
                let alert = UIAlertController(title: "success", message: "code verified", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default,handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                self.submitcode.isEnabled = false
                self.submitpass.isEnabled = true
                
            case .failure(let json):
                let alert = UIAlertController(title: "failure", message: "code not verified", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default,handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
            }
        }
    }
    
    @IBAction func submitpassTapped(_ sender: Any) {
        let userId = self.userId!
        let pass = self.newtf.text!
        let confirmpass = self.confirmtf.text!
        if pass != confirmpass {
            let alert = UIAlertController(title: "error", message: "two password must match", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default,handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else{
            LoginViewModel1.instance.changepassword(userId: userId, password: pass){
                result in
                switch result{
                case .success(let json):
                    self.alertmessage(message: "password has been changed", title: "success")
                    
                case .failure(let json):
                    let alert = UIAlertController(title: "failure", message: "no changes", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default,handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
            
            
        }
       
    }
    func alertmessage(message:String,title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default){ action ->Void in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    
            self.navigationController?.pushViewController(objSomeViewController, animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
}
