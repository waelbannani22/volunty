//
//  ForgetPasswordViewController.swift
//  volunty
//
//  Created by wael bannani on 28/11/2021.
//

import UIKit


//widgets

class ForgetPasswordViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var submitlabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emaillabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emaillabel.delegate = self
        myview.layer.cornerRadius = 20.0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitTapped(_ sender: Any) {
        LoginViewModel1.instance.verifmail(email: emaillabel.text!){
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
            let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "VerifcodeViewController") as! VerifcodeViewController
            objSomeViewController.codePassed = code
            objSomeViewController.userId = userId
            self.navigationController?.pushViewController(objSomeViewController, animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    

}
