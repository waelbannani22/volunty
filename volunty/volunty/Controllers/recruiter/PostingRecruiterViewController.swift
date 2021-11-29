//
//  PostingRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit

class PostingRecruiterViewController: UIViewController ,UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate {

    @IBOutlet weak var submitbuuton: UIButton!
    @IBOutlet weak var descriptiontf: UITextView!
    @IBOutlet weak var citytf: UITextField!
    @IBOutlet weak var addresstf: UITextField!
    @IBOutlet weak var begintimetf: UITextField!
    @IBOutlet weak var targetagetf: UITextField!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var nametf: UITextField!
    //var
    var token :String?
    var userId :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptiontf.delegate = self
        citytf.delegate = self
        addresstf.delegate = self
        begintimetf.delegate = self
        targetagetf.delegate = self
        category.delegate = self
        nametf.delegate = self
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        if (descriptiontf.text == ""||citytf.text == "" || addresstf.text == "" || targetagetf.text == "" ||  nametf.text == ""   ){
            let alert = UIAlertController(title: "failure", message: "fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
            
            
        }else{
            print("token",token!,"id",userId)
            PostingViewModel.instance.postingcall(token: token!, name: nametf.text!, city: citytf.text!, dateBegin: "", description: descriptiontf.text!, recruiter: userId!, ageGroupe: targetagetf.text!, category: ""){
                result in
                switch result {
                case .success(let json):
                    let alert = UIAlertController(title: "succes", message: "post has been created", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                case .failure(let json):
                    let alert = UIAlertController(title: "failure", message: "nothing created", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
        }
    }
    
   
}
