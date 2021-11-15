//
//  VolunteerEditProfileViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit

class VolunteerEditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DateTapped(_ sender: Any) {
        performSegue(withIdentifier: "date", sender: nil)
    }
    @IBOutlet weak var dateButton: UIButton!
    
    
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
   

}
