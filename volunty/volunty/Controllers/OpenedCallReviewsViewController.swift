//
//  OpenedCallReviewsViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit
import SwiftyJSON

class OpenedCallReviewsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    var id :String?
    var size = 0
    //widgets
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var no: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        createReview()
        HomeVolunteer.instance.fetchReview(id: id!){ [self]
            result in
            switch result {
            case .success(let json):
                let json2 = JSON(json!)
                self.size = json2["review"].count
                if self.size == 0 {
                    self.no.isHidden = false
                }else{
                    self.no.isHidden = true
                }
                
                self.tv.reloadData()
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
  
    }
    func createReview(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    @objc func didTapAdd (){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "WriteReviewViewController") as! WriteReviewViewController
       
        objSomeViewController.id = id
    
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let name = contentView?.viewWithTag(1) as! UILabel
        let date = contentView?.viewWithTag(2) as! UILabel
        let desc = contentView?.viewWithTag(3) as! UILabel
        cell!.layer.cornerRadius = 20
       // cell!.layer.backgroundColor = CGColor.init(red: 150.1, green: 12.2, blue: 60.0, alpha: 1)
        //fetch
        cell!.layer.borderColor = CGColor.init(red: 12.2, green: 12.2, blue: 12.2, alpha: 1)
            //fetch
        HomeVolunteer.instance.fetchReview(id: id!){
            result in
            switch result {
            case .success(let json):
                let json2 = JSON(json!)
                name.text = json2["review"][indexPath.row]["reviewerName"].string
                date.text = json2["review"][indexPath.row]["date"].string
                desc.text = json2["review"][indexPath.row]["reviewDescription"].string
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        return cell!
    }
}
