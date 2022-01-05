//
//  AuthorizeViewController.swift
//  volunty
//
//  Created by wael bannani on 26/12/2021.
//

import UIKit
import LocalAuthentication

class AuthorizeViewController: UIViewController {

    @IBOutlet weak var authorize: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func authorizeTapped(_ sender: Any) {
        let context = LAContext()
        let error : NSErrorPointer = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: error){
            let reason = "please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){
                 [weak self] success , error in
                DispatchQueue.main.async {
                    guard success,error == nil else {
                        let alert = UIAlertController(title: "failed to authentificate", message: "please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert,animated: true)
                        return
                    }
                    self?.performSegue(withIdentifier: "authorize", sender: nil)
                }
            }
        }else{
            let alert = UIAlertController(title: "unavailable", message: "you cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
        
    }
    

}
