//
//  verifcodeRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 21/12/2021.
//

import UIKit

class verifcodeRecruiterViewController: UIViewController {

    //var
    var codePassed : String?
    var userId : String?
    //widgets
    
    @IBOutlet weak var myview2: UIView!
    @IBOutlet weak var myview1: UIView!
    @IBOutlet weak var submitcode: UIButton!
    @IBOutlet weak var submitpass: UIButton!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var code: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitpass.isEnabled = false;
        myview1.layer.cornerRadius = 20.0
        myview2.layer.cornerRadius = 20.0

    }
    
    @IBAction func submitCode(_ sender: Any) {
        let codep = codePassed!
        let code = self.code.text!
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
    
    @IBAction func submitPass(_ sender: Any) {
        let userId = self.userId!
        let pass = self.newpass.text!
        let confirmpass = self.confirmpass.text!
        if pass != confirmpass {
            let alert = UIAlertController(title: "error", message: "two password must match", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default,handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else{
            PostingViewModel.instance.changepassword(userId: userId, password: pass){
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
            let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginRecruiterViewController") as! LoginRecruiterViewController
    
            self.navigationController?.pushViewController(objSomeViewController, animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
   
}
