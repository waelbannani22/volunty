//
//  AddDonationViewController.swift
//  volunty
//
//  Created by wael bannani on 11/12/2021.
//

import UIKit
import PhotosUI

class AddDonationViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    
    //var
    var amountV = 0.0
    let datapicker = UIDatePicker()
    //widgets
    @IBOutlet weak var name: UITextField!
   
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var `import`: UIButton!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var organisation: UITextField!
    @IBOutlet weak var location: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        image.addGestureRecognizer(tapGR)
        image.isUserInteractionEnabled = true
        //createImagePicker()
        deadline.inputView = datapicker
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow ), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector( keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
  
   
    

        //keyboard
        @objc private func hideKeyboard(){
            self.view.endEditing(true)
        }
    var isExpend = false
        @objc private func keyboardWillShow(){
            if !isExpend {
                self.scroll.contentSize = CGSize(width: self.view.frame.width, height: self.scroll.frame.height + 300)
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
            self.image.backgroundColor = UIColor.systemBackground
            
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
            
            actionSheetController.popoverPresentationController?.sourceView = self.view
        let xOrigin = self.view.center.x // Replace this with one of the lines at the end
        let popoverRect = CGRect(x: xOrigin, y: self.image.frame.origin.y + 50, width: 1, height: 1)
            actionSheetController.popoverPresentationController?.sourceRect = popoverRect
            actionSheetController.popoverPresentationController?.permittedArrowDirections = .up
            
            actionSheetController.addAction(deleteActionButton)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(adddate))
        
        toolbar.setItems([btn], animated: true)
        deadline.inputAccessoryView = toolbar
        deadline.inputView = datapicker
        datapicker.datePickerMode = .date
        
    }
    @objc func adddate(){
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
        //formater.dateStyle = .medium
       // formater.timeZone = .current
        //formater.timeStyle = .short
        deadline.text = formater.string(from: datapicker.date)
        self.view.endEditing(true)
        
    }
    
    func dateVerif(datee:String)->Bool{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let someDate = dateFormatter.date(from: datee)
        
        //Get calendar
        let calendar = NSCalendar.current
        let today = calendar.startOfDay(for: Date.now)
        let todayfor = dateFormatter.string(from: today)
        let todayformated = dateFormatter.date(from: todayfor)

        

        if someDate! > todayformated! {
           return true
        } else {
            return false
        }
    }
    func makealert(value:String){
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
    @IBAction func submit(_ sender: Any) {
        let defaults = UserDefaults.standard
        let name = self.name.text
      
        let desc = self.desc.text!
        let phone = self.phone.text!
        let organisation = self.organisation.text!
        let location = self.location.text!
        let dated = self.deadline.text!
         let id = defaults.value(forKey: "recruiterId") as! String
        //api
        if (name == ""  || desc == "" || phone == "" || location == "" || dated == "" || self.image.image == Optional(nil)) {
            
            let alert = UIAlertController(title: "warning", message: "please fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else if !dateVerif(datee: deadline.text!) {
            makealert(value: "please add a valid date ")
        }else if (!validatePhone(value: phone)){
            makealert(value: "please add a valid phone number")
        }else{
            PostingViewModel.instance.addDonation(recruiterId: id, name: name!, location: location, organisation: organisation, deadline: self.deadline.text!, phone: phone, photo: self.image.image!, montantTotal: "0", description: desc){
                result in
                switch result {
                
                case .success(_):
                    let alert = UIAlertController(title: "success", message: "donation added!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default){action ->Void in
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "MyDonationViewController") as! MyDonationViewController
                      
                      
                        self.navigationController?.pushViewController(objSomeViewController, animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                  //  self.dismiss(animated: true)
                case .failure(_):
                    let alert = UIAlertController(title: "failure", message: "something went wrong!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    @IBAction func deadlineButton(_ sender: Any) {
    }
    
    @IBAction func importTapped(_ sender: Any) {
    }
    

}
