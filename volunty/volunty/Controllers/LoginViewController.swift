//
//  LoginViewController.swift
//  volunty
//
//  Created by wael bannani on 5/11/2021.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    //widgets
    @IBOutlet weak var emailTextFiield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextFiield{
            passwordTextField.becomeFirstResponder()
        }else{
            textField.endEditing(true)
            if checkingUserInfo(){
                signInTapped(self)
            }
        }
        return true
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

    @IBAction func signInTapped(_ sender: Any) {
        //LoginViewModel.login()
        if checkingUserInfo() == true{ // Making sure email and pass match the rules
            indicatorStart(true)
        UserAuth.instance.login(email: emailTextFiield.text!, password: passwordTextField.text!){ result in
                switch result{
                    
                              case .success(_):
                                  self.indicatorStart(false)
                                  print("Successfully signed in user")
                                NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: true)
                                 self.dismiss(animated: true, completion: nil)
                              case .failure(_):
                                    self.indicatorStart(false)
                                   // print(self.emailTextFiield.text!,self.passwordTextField.text!)
                                    //self.performSegue(withIdentifier: "retry", sender: "volunteer")
                                    print("this is a recruiter account")
                  
                              }
            
                    
        }}
        else{
            let alert = UIAlertController(title: "failed", message: "authentification failed", preferredStyle: .alert)
            let action = UIAlertAction(title: "retry", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }
        
    }
                           
                        
                            
                        
                    
               
    

  
}
