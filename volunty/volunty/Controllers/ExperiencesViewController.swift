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
    var json2 : JSON?
    var size = 0
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
                self.size = (defaults.value(forKey: "size") as? Int)!
                self.tv.reloadData()
                if self.size == 0 {
                    self.makealert(value: "no available calls in this category ! \n please check it later")
                }
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        //delegate
        tv.delegate = self
        tv.dataSource = self
        
        
    }
    func makealert(value:String){
        let alert = UIAlertController(title: "failure", message: value, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let name = contentView.viewWithTag(2) as! UILabel
        let city = contentView.viewWithTag(3) as! UILabel
        let imageV = contentView.viewWithTag(1) as! UIImageView
        HomeVolunteer.instance.fetchByCategory(category: categoryName!){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json as Any)
               
                name.text = json1["call"][indexPath.row]["name"].string
                city.text = json1["call"][indexPath.row]["city"].string
                let img = json1["call"][indexPath.row]["photo"].string
                ImageLoader.shared.loadImage(
                 identifier: img!,
                    url: "http://localhost:3000/img/\(img!)",
                    completion: { image in
                        imageV.image = image!
                        
                    })
            case .failure(let value):
                print(value.localizedDescription)
            }
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = CGColor.init(red: 12.2, green: 12.2, blue: 12.2, alpha: 1)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HomeVolunteer.instance.fetchByCategory(category: categoryName!){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json as Any)
                self.json2 = json1["call"][indexPath.row]
              
                self.performSegue(withIdentifier: "Segue", sender: self.json2)
            case .failure(let value):
                print(value.localizedDescription)
            }
          
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let json = sender as! JSON
            let destination = segue.destination as! OpenedCallViewController
            destination.json = json
        }
    }

   

}
