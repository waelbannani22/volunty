//
//  emailSentViewController.swift
//  volunty
//
//  Created by wael bannani on 21/12/2021.
//

import UIKit

class emailSentViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        email.delegate = self
        myview.layer.cornerRadius = 20.0
    }
    
    @IBAction func submit(_ sender: Any) {
        PostingViewModel.instance.verifmail(email: email.text!){
            result in
            switch result{
            case .success(let json):
                let code = (json as AnyObject).value(forKey: "code") as! String?
                let userId = (json as AnyObject).value(forKey: "id") as! String?
                self.alertmessage(message: "valid email", title: "check your mail please!", code: code!, userId : userId!)
                print(code)
            case .failure(let json):
                let alert = UIAlertController(title: "failure", message: "invalid email", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default,handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                print("error")
            }
        }
    }
    func alertmessage(message:String,title:String, code :String,userId : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default){ action ->Void in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "verifcodeRecruiterViewController") as! verifcodeRecruiterViewController
            objSomeViewController.codePassed = code
            objSomeViewController.userId = userId
            self.navigationController?.pushViewController(objSomeViewController, animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    

}
