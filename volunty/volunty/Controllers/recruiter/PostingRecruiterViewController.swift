//
//  PostingRecruiterViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit
import Photos
import PhotosUI

class PostingRecruiterViewController: UIViewController ,UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categorypicked = pickerData[row]
    }
    

   
    
   
   
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var submitbuuton: UIButton!
    @IBOutlet weak var descriptiontf: UITextView!
    @IBOutlet weak var citytf: UITextField!
    @IBOutlet weak var addresstf: UITextField!
    @IBOutlet weak var begintimetf: UITextField!
    
    
    @IBOutlet weak var targetagetf: UITextField!
    @IBOutlet weak var nametf: UITextField!
    //var
    var token :String?
    var userId :String?
    var pickerData:  [String] = [String]()
    var categorypicked :String? = "ANIMAL"
    let datapicker = UIDatePicker()
    //var images = UIImage?.self
    var ur : URL?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptiontf.delegate = self
        citytf.delegate = self
        addresstf.delegate = self
        begintimetf.delegate = self
        targetagetf.delegate = self
        category.delegate = self
        nametf.delegate = self
        category.delegate = self
        category.dataSource = self
        pickerData = ["ANIMAL", "CHILDREN", "COMMUNITY", "DISABILITY", "EDUCATION", "ENVIRONMENT", "HEALTH", "HOMELESS", "SENIOR"]
        createDatePicker()
        createImagePicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
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
            let buttomSpace = self.view.frame.height - (submitbuuton.frame.origin.y + submitbuuton.frame.height)
            self.view.frame.origin.y = keyboardHeight - buttomSpace
        }
    }
    @objc private func keyboardWillHide(){
       
    }
    
    
    func createImagePicker(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showActionSheet))
        navigationItem.rightBarButtonItem?.title = "add image"
    }
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX  = "\\d{8}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
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
 
    func camera()
      {
          let myPickerControllerCamera = UIImagePickerController()
          myPickerControllerCamera.delegate = self
          myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
          myPickerControllerCamera.allowsEditing = true
          self.present(myPickerControllerCamera, animated: true, completion: nil)
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
        
    @objc func showActionSheet(){
            
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
        let xOrigin = self.view.layer.frame.origin.x // Replace this with one of the lines at the end
        let popoverRect = CGRect(x: xOrigin, y: 0, width: 1, height: 1)
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
        begintimetf.inputAccessoryView = toolbar
        begintimetf.inputView = datapicker
        datapicker.datePickerMode = .date
        
    }
    @objc func adddate(){
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
      //  formater.dateStyle = .short
       // formater.timeZone = .current
//formater.timeStyle = .short
        begintimetf.text = formater.string(from: datapicker.date)
        self.view.endEditing(true)
        
    }
   
    func makealert (value:String){
        let alert = UIAlertController(title: "warning", message: value, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func submitTapped(_ sender: Any) {
        if (descriptiontf.text == ""||citytf.text == "" || addresstf.text == "" || targetagetf.text == "" ||  nametf.text == "" ||  begintimetf.text == ""  ){
            let alert = UIAlertController(title: "warning", message: "fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else if !dateVerif(datee: begintimetf.text!) {
            
            makealert(value: "please add a valid date")
            
        }else{
           // print("token",token!,"id",userId)
            let defaults = UserDefaults.standard
            PostingViewModel.instance.postingcall1(token: defaults.value(forKey: "recruitertoken")! as! String, name: nametf.text!, city: citytf.text!, dateBegin: begintimetf.text!, description: descriptiontf.text!, recruiter: defaults.value(forKey: "recruiterId")! as! String, ageGroupe: targetagetf.text!, category: categorypicked!, photo:self.image.image!){
                result in
                let defaults = UserDefaults.standard
                switch result {
                case .success(let json):
                    let alert = UIAlertController(title: "success", message: "post created", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default){action ->Void in
                      
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "MyPostsViewController") as! MyPostsViewController
                      
                      
                        self.navigationController?.pushViewController(objSomeViewController, animated: true)
                    }
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
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {return nil}
            
            let transformScale = CGAffineTransform(scaleX: 5.0, y: 5.0)
            let scaledQRImage = QRImage.transformed(by: transformScale)
            
            return UIImage(ciImage: scaledQRImage)
        }
        return nil
    }
    
   
}


