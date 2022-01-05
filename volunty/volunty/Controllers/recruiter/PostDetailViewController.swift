//
//  PostDetailViewController.swift
//  volunty
//
//  Created by wael bannani on 14/11/2021.
//

import UIKit
import SwiftyJSON

class PostDetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    
    //var
    var index:Int?
    public var  userid :String?
    var r : JSON?
     let refreshControl = UIRefreshControl()
    var size = 0
    var img = ""
    //widgets
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var lo: UIImageView!
    @IBOutlet weak var gr: UIImageView!
    @IBOutlet weak var da: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var accepted: UILabel!
    @IBOutlet weak var pending: UILabel!
    @IBOutlet weak var declined: UILabel!
    @IBOutlet weak var buttonDeclined: UIButton!
    
    @IBOutlet weak var acceptedbnt: UIButton!
    @IBOutlet weak var pendingbtn: UIButton!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var groupelabel: UILabel!
    override func viewDidLoad() {
        stack.layer.cornerRadius = 20.0
        tv.delegate = self
        tv.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        super.viewDidLoad()
        tv.isHidden = true
        let defaults = UserDefaults.standard
        PostingViewModel.instance.FetchPostsByRecruiter(token:defaults.value(forKey: "recruitertoken") as! String , recruiter: defaults.value(forKey: "recruiterId") as! String){ [self]
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
               
                if json1["call"][self.index!]["name"].string == Optional(nil){
                    let alert = UIAlertController(title: "NO DATA AVAILABLE", message: "Please return to the previous page ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert , animated: true)

                }else{
                    
                    self.namelabel.text = json1["call"][self.index!]["name"].string!
                    defaults.setValue(self.namelabel.text!, forKey: "nameCall")
                    self.datelabel.text = json1["call"][self.index!]["dateBegin"].string!
                    self.groupelabel.text = json1["call"][self.index!]["ageGroup"].string!
                    self.locationlabel.text = json1["call"][self.index!]["city"].string!
                    print(json1["call"][self.index!]["pending"].int)
                    self.accepted.text = json1["call"][self.index!]["accepted"].int?.formatted()
                    self.declined.text = json1["call"][self.index!]["declined"].int?.formatted()
                    self.pending.text = json1["call"][self.index!]["pending"].int?.formatted()
                    self.userid = json1["call"][self.index!]["_id"].string!
                    let user = json1["call"][self.index!]["_id"].string!
                    print ("user",user)
                    defaults.setValue(user, forKey: "usercall1")
                    defaults.setValue(json1["call"][self.index!]["_id"].string!, forKey: "indexcall")
                    print(defaults.value(forKey: "usercall1"))
                    print("self",self.userid)
                    let im = json1["call"][self.index!]["photo"].string
                    
                    if im != Optional(nil){
                        self.img = im!
                        waitForImage()
                    }
                   
                    PostingViewModel.instance.FetchPostsBycallId(callId: self.userid!){
                        result in
                            switch result {
                            case .success(let json):
                                let json2 = JSON(json)["call"]
                                print(json2)
                                let size = json2.count
                               
                                defaults.setValue(size, forKey: "sizejson2")
                                print("size=",defaults.value(forKey: "sizejson2")!)
                                self.size = defaults.value(forKey: "sizejson2")  as! Int
                                tv.reloadData()
                            case .failure(let json):
                                print("failure",json)
                            }
                        
                    }
                   
                  
                  
              
                }
            case .failure(let value):
                print("errer",value)
            }
            //2eme
            //print(defaults.value(forKey: "userId") )
           
        
            
            
        }
         }
    func waitForImage() {
           ImageLoader.shared.loadImage(
            identifier: self.img,
               url: "http://localhost:3000/img/\(self.img)",
               completion: { [self]image in
                   self.image.image = image
                   
               })
       }
                
    @objc func refresh(sender:AnyObject)
    {
        // Updating your data here...

        self.tv.reloadData()
        self.refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return size
    }
    
    
    @IBAction func declinedTapped(_ sender: Any) {
        self.tv.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let defaults = UserDefaults.standard
        defaults.synchronize()
        print("default table",defaults.value(forKey: "usercall1")!)
        PostingViewModel.instance.FetchPostsBycallId(callId: defaults.value(forKey: "usercall1") as! String) {
            result in
                switch result {
                case .success(let json):
                    let json2 = JSON(json)["call"]
                    let contentView = cell.contentView
                    let name = contentView.viewWithTag(1) as! UILabel
                    let status = contentView.viewWithTag(2) as! UILabel
                    name.text = json2[indexPath.row]["username"].string
                    let row = json2[indexPath.row]["status"].string
                    if row != nil {
                        print(row!)
                        if row! == "accepted"{
                            status.textColor = UIColor.green
                        }
                        if row! == "pending"{
                            status.textColor = UIColor.orange
                        }
                        if row! == "declined"{
                            status.textColor = UIColor.red
                        }
                    }
                   
                
                    status.text = json2[indexPath.row]["status"].string
                    
                    self.r = json2
                    let size = json2.count
                   
                    defaults.setValue(size, forKey: "sizejson2")
                    print("size=",defaults.value(forKey: "sizejson2")!)
                case .failure(let json):
                    print("failure",json)
                }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let t = "61a40fb8241d970d16aae647"
        var rt = self.r![indexPath.row]
        print("selected",rt)
        performSegue(withIdentifier: "Seguev", sender: rt)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Seguev"{
            let value = sender as! JSON
           
            let destination = segue.destination as! GestionVolunteerViewController
            destination.valueJson = value
        }
    }
    
    

}
