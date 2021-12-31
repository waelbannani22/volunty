//
//  VolunteerEditProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit
import PhotosUI
class VolunteerEditProfileViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //widgets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fullnamelabel: UITextField!
    @IBOutlet weak var usernamelabel: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var age: UITextField!
    //var
    var token:String?
    var id :String?
    var tokenEdit :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        image.addGestureRecognizer(tapGR)
        image.isUserInteractionEnabled = true
        
        fullnamelabel.delegate = self
        usernamelabel.delegate = self
   //     print("toekn initiale",token)
        let defaults = UserDefaults.standard
        //self.tokenEdit = defaults.string(forKey: "jsonwebtoken")!
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector( keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
            
            self.image.image = selectedImage
           
            
            self.dismiss(animated: true, completion: nil)
        }
        
    @objc  func showActionSheet(){
            
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
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX  = "\\d{2}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX  = "\\d{8}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func makealert(value:String){
        let alert = UIAlertController(title: "failure", message: value, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func saveChanges(_ sender: Any) {
        
        let fullname = fullnamelabel.text!
        let username = usernamelabel.text!
        
        if fullname == "" || username == "" || self.phone.text == "" || self.age.text == "" {
            makealert(value: "fill all fields")
        }else if (!validate(value: self.age.text!)) {
            makealert(value: "fill a valid age")
        }else if (validatePhone(value: self.phone.text!)) {
            makealert(value: "please fill a valid phone number")
        }else{
        //print(self.tokenEdit)
        print(fullname," ",username)
        HomeVolunteer.instance.updateUser(id: id!, token: self.token!, username: username, lastname: fullname, photo: self.image.image!){
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
