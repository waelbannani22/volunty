//
//  WriteReviewViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit

class WriteReviewViewController: UIViewController {

    @IBOutlet weak var desclabel: UITextView!
    var id :String?
    var idv:String?
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.idv = defaults.value(forKey: "volunteerId") as! String?
        self.name = defaults.value(forKey: "usernamev") as! String?
        

      
    }
    

    @IBAction func submit(_ sender: Any) {
        HomeVolunteer.instance.addReview(id: id!, name: name!, idv: self.idv!, desc: self.desclabel.text){
            result in
            switch    result{
            case .success(let json):
                let alert = UIAlertController(title: "success", message: "your review has been submited", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
            case .failure(let value):
                let alert = UIAlertController(title: "failure", message: value.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                
            }
            
            
        }
    }
    

}
