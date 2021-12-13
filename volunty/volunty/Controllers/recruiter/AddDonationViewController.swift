//
//  AddDonationViewController.swift
//  volunty
//
//  Created by wael bannani on 11/12/2021.
//

import UIKit
import PhotosUI

class AddDonationViewController: UIViewController,PHPickerViewControllerDelegate {
   
    
    //var
    var amountV = 0.0
    let datapicker = UIDatePicker()
    //widgets
    @IBOutlet weak var name: UITextField!
   
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
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapAdd))
        image.addGestureRecognizer(tapGR)
        image.isUserInteractionEnabled = true
    }
    
    @objc private func didTapAdd(){
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc,animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        let group = DispatchGroup()
        results.forEach{
            result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self){
                reading, error in
                defer {
                    group.leave()
                }
                guard let image = reading as? UIImage , error == nil else{
                    return
                }
                group.notify(queue: .main){
                    print(image)
                  
                    self.image.image = image
                   
                    
                }
               
            }
        }
        
    }
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(adddate))
        
        toolbar.setItems([btn], animated: true)
        deadline.inputAccessoryView = toolbar
        deadline.inputView = datapicker
        datapicker.datePickerMode = .dateAndTime
        
    }
    @objc func adddate(){
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeZone = .current
        formater.timeStyle = .short
        deadline.text = formater.string(from: datapicker.date)
        self.view.endEditing(true)
        
    }
    @IBAction func submit(_ sender: Any) {
        let defaults = UserDefaults.standard
        let name = self.name.text
      
        let desc = self.desc.text!
        let phone = self.phone.text!
        let organisation = self.organisation.text!
        let location = self.location.text!
         let id = defaults.value(forKey: "recruiterId") as! String
        //api
        if (name == ""  || desc == "" || phone == "" || location == "" ) {
            //self.amountV = Double(self.amount.text!)!
            //let amountT = Int(self.amountV)
            let alert = UIAlertController(title: "warning", message: "please fill all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }else{
            PostingViewModel.instance.addDonation(recruiterId: id, name: name!, location: location, organisation: organisation, deadline: self.deadline.text!, phone: phone, photo: self.image.image!, montantTotal: "0", description: desc){
                result in
                switch result {
                
                case .success(_):
                    let alert = UIAlertController(title: "success", message: "donation added!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default){action ->Void in
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "MyPostsViewController") as! MyPostsViewController
                      
                      
                        self.navigationController?.pushViewController(objSomeViewController, animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    self.dismiss(animated: true)
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
