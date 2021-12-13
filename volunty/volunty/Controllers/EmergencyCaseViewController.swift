//
//  EmergencyCaseViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit
import SwiftyJSON
class EmergencyCaseViewController: UIViewController {
    //var
    var index :Int?
    //widgets
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var name: UILabel!
   
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let id = defaults.value(forKey: "recruiterId") as! String
        //api
        PostingViewModel.instance.fetchDonation(recruiterId: id){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                self.desc.text = json1["donation"][self.index!]["description"].string
                self.name.text =  json1["donation"][self.index!]["name"].string
                let img = json1["donation"][self.index!]["photo"].string
                self.target.text = json1["donation"][self.index!]["montantTotal"].string
                 ImageLoader.shared.loadImage(
                  identifier: img!,
                     url: "http://localhost:3000/img/\(img!)",
                     completion: { image in
                         self.imageV.image = image!
                         
                     })
            case .failure(let value):
                print(value.localizedDescription)
            }
        }

        
    }
    

}
