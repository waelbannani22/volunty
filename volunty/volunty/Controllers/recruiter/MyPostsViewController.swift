//
//  MyPostsViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit

class MyPostsViewController: UIViewController {

    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        namelabel.text! = defaults.value(forKey: "name") as! String
        

        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "PostingRecruiterViewController") as! PostingRecruiterViewController
        objSomeViewController.userId = defaults.value(forKey: "recruiterId")! as! String
        objSomeViewController.token = defaults.value(forKey: "recruitertoken")! as! String
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
    }
    
  

}
