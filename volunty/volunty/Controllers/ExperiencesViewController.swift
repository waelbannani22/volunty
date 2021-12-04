//
//  ExperiencesViewController.swift
//  volunty
//
//  Created by wael bannani on 7/11/2021.
//

import UIKit
import SwiftyJSON

class ExperiencesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    var categoryName : String?
    //var
    //widgets
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(categoryName!)
        let defaults = UserDefaults.standard
        //fetch
        HomeVolunteer.instance.fetchByCategory(category: categoryName!){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json as Any)
                defaults.setValue(json1["call"].count, forKey: "size")
                defaults.synchronize()
                self.tv.reloadData()
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        //delegate
        tv.delegate = self
        tv.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        return defaults.value(forKey: "size") as! Int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let name = contentView.viewWithTag(2) as! UILabel
        let city = contentView.viewWithTag(3) as! UILabel
        
        HomeVolunteer.instance.fetchByCategory(category: categoryName!){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json as Any)
                name.text = json1["call"][indexPath.row]["name"].string
                city.text = json1["call"][indexPath.row]["city"].string
                
            case .failure(let value):
                print(value.localizedDescription)
            }
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = CGColor.init(red: 12.2, green: 12.2, blue: 12.2, alpha: 1)
        }
        return cell
    }

   

}
