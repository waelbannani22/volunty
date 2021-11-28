//
//  VolunteerEditProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit

class VolunteerEditProfileViewController: UIViewController ,UITextFieldDelegate{

    //widgets
    @IBOutlet weak var fullnamelabel: UITextField!
    @IBOutlet weak var usernamelabel: UITextField!
    //var
    var token:String?
    var id :String?
    var tokenEdit :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullnamelabel.delegate = self
        usernamelabel.delegate = self
   //     print("toekn initiale",token)
        let defaults = UserDefaults.standard
        self.tokenEdit = defaults.string(forKey: "jsonwebtoken")!
        print("token edit",tokenEdit)
        
    }
    
    
    @IBAction func DateTapped(_ sender: Any) {
        performSegue(withIdentifier: "date", sender: nil)
    }
    @IBOutlet weak var dateButton: UIButton!
    
    
    @IBAction func saveChanges(_ sender: Any) {
        let fullname = fullnamelabel.text!
        let username = usernamelabel.text!
        //print(self.tokenEdit)
        print(fullname," ",username)
        HomeVolunteer.instance.updateUser(id: id!, token: tokenEdit!, username: username, lastname: fullname){
            result in
            print(result)
            switch result {
            case .success(let json):
                self.alertmessage(message: "saved changes ", title: "success")
            case .failure(let json):
                self.alertmessage(message: "cannot save changes", title: "failure")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "location"{
         //   let destination = segue.destination as! WalkthroughLocationVC
       //     destination.isSignUp = true
       // }
        
        if segue.identifier == "date"{
            let destination = segue.destination as! DateSelectionViewController
            destination.selectedDate = dateButton.currentTitle!
        }
        
       // if segue.identifier == "error"{
       //     let destination = segue.destination as! LoginMessage
      //      destination.message = "All fields are required to be fllled out and an image needs to be selected!"
       // }
        
    }
    func alertmessage(message:String,title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default,handler: nil)
        //{action ->Void in
          //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVolunteerViewController") as! HomeVolunteerViewController
            //self.navigationController?.pushViewController(objSomeViewController, animated: true)
        //}
        alert.addAction(action)
        self.present(alert,animated: true)
    }
   

}
