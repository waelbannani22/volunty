//
//  RecruiterProfileEditViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON
import PhotosUI
class RecruiterProfileEditViewController: UIViewController,PHPickerViewControllerDelegate {

    //VAR
    //WIDGETS
    @IBOutlet weak var IMAGE: UIImageView!
    @IBOutlet weak var namelabel: UITextField!
    @IBOutlet weak var emaillabel: UITextField!
    
    @IBOutlet weak var phoneLabel: UITextField!
   
    @IBOutlet weak var company: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapAdd))
        IMAGE.addGestureRecognizer(tapGR)
        IMAGE.isUserInteractionEnabled = true
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
                  
                    self.IMAGE.image = image
                   
                    
                }
               
            }
        }
        
    }
    
    @IBAction func edit(_ sender: Any) {
      
        
    }
    
    @IBAction func save(_ sender: Any) {
        let defaults = UserDefaults.standard
        let recruiteriD = defaults.value(forKey: "recruiterId") as! String
        print(" start updating")
       // let token = defaults.value(forKey: "recruitertoken")as! String
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
