//
//  ViewController.swift
//  volunty
//
//  Created by wael bannani on 5/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "welcome"
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var welcome: UILabel!
    
    @IBOutlet weak var rectangle1: UIImageView!
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fkesh: UIButton!
   
    @IBAction func buttonNext(_ sender: Any) {
    }
  
    @IBOutlet weak var help: UILabel!
    @IBOutlet weak var looking: UILabel!
    @IBOutlet weak var image1: UIImageView!
}

