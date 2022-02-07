//
//  RecruiterProfileEditViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON
import PhotosUI
class RecruiterProfileEditViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //VAR
    //WIDGETS
    @IBOutlet weak var IMAGE: UIImageView!
    @IBOutlet weak var namelabel: UITextField!
    @IBOutlet weak var emaillabel: UITextField!
    
    @IBOutlet weak var phoneLabel: UITextField!
   
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var company: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        IMAGE.addGestureRecognizer(tapGR)
        IMAGE.isUserInteractionEnabled = true
        IMAGE.layer.cornerRadius = 10.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector( keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let defaults = UserDefaults.standard
        let recruiteriD = defaults.value(forKey: "recruiterId") as! String
    
        PostingViewModel.instance.fetchRecruiter(recruiterId: recruiteriD){
            result in
            switch result {
            case .success(let json ):
                    let json1 = JSON(json)
                print (json1["user"][0]["email"])
                let nameValue = json1["user"][0]["name"].string
                let emailValue = json1["user"][0]["email"].string
                let companyValue = json1["user"][0]["organisation"].string
                let phoneValue =  json1["user"][0]["phone"].string
                let image = json1["user"][0]["photo"].string
                if image != Optional(nil){
                    ImageLoader.shared.loadImage(
                     identifier: image!,
                        url: "http://localhost:8885/img/\(image!)",
                        completion: { image in
                            self.IMAGE.image = image!
                            
                        })
                }
                self.namelabel.text = nameValue!
                self.emaillabel.text = emailValue!
                self.company.text = companyValue!
                self.phoneLabel.text = phoneValue!
                self.emaillabel.isEnabled = false
                self.company.isEnabled = false;
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        
    }
    //keyboard
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
    }
    @objc private func keyboardWillShow(notification:NSNotification){
        if let keyboardFrame :NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let buttomSpace = self.view.frame.height - (saveButton.frame.origin.y + saveButton.frame.height)
            self.view.frame.origin.y = keyboardHeight - buttomSpace
        }
    }
    @objc private func keyboardWillHide(){
        self.view.frame.origin.y = 0
    }
    func gallery()
        {
            let myPickerControllerGallery = UIImagePickerController()
            myPickerControllerGallery.delegate = self
            myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
            myPickerControllerGallery.allowsEditing = true
            self.present(myPickerControllerGallery, animated: true, completion: nil)
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            
            self.IMAGE.image = selectedImage
           
            
            self.dismiss(animated: true, completion: nil)
        }
        
    @objc  func showActionSheet(){
        self.hideKeyboard()
            let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
            actionSheetController.view.tintColor = UIColor.black
            let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
                print("Cancel")
            }
            actionSheetController.addAction(cancelActionButton)
            
           
            
            let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
            { action -> Void in
                self.gallery()
            }
            
            actionSheetController.addAction(deleteActionButton)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    
    
    func alert (value:String){
        let alert = UIAlertController(title: "warning", message: value, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX  = "\\d{8}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

    
    @IBAction func save(_ sender: Any) {
        let defaults = UserDefaults.standard
        let recruiteriD = defaults.value(forKey: "recruiterId") as! String
        print(" start updating")
        
       // let token = defaults.value(forKey: "recruitertoken")as! String
        
        if (self.IMAGE.image == Optional(nil)){
            let alert = UIAlertController(title: "warning", message: "please add an image", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else if (self.namelabel.text == "" || self.phoneLabel.text == "" ){
                alert(value: "please fill all fields")
        }
        else if !validatePhone(value: self.phoneLabel.text!){
            alert(value: "please fill a valid phone number")
        }else{
        PostingViewModel.instance.updateRecruiter(recruiterId: recruiteriD,  name: self.namelabel.text!, phone: self.phoneLabel.text!, photo: self.IMAGE.image!){
            result in
            switch result {
            case .success(let json):
               print("updated")
            
            case .failure(let value):
                print(value.localizedDescription)
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "RecruiterProfileViewController") as! RecruiterProfileViewController
               self.tabBarController?.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(objSomeViewController, animated: true)
            
        }
        }
       
        
    }
    

}
