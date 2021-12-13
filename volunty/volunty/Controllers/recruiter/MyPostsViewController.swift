//
//  MyPostsViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit
import SwiftyJSON
import CoreAudio

class MyPostsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
  
    
   
    

    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    
    @IBOutlet weak var refresh: UIButton!
    var sizeofjson :Int?
    var Js : JSON?
    let refreshControl = UIRefreshControl()
    let groupe = DispatchGroup()
    var size = 0
    override func viewDidLoad() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
          refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        let defaults = UserDefaults.standard
        defaults.synchronize()
        namelabel.text! = defaults.value(forKey: "name") as! String
    
        PostingViewModel.instance.FetchPostsByRecruiter(token:defaults.value(forKey: "recruitertoken") as! String , recruiter: defaults.value(forKey: "recruiterId") as! String){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                self.Js = json1
                self.sizeofjson = json1["call"].count
            
                defaults.setValue(json1["call"].count, forKey: "sizeof")
                defaults.synchronize()
                self.size = defaults.value(forKey: "sizeof") as! Int
                self.tv.reloadData()
                print("default",defaults.value(forKey: "sizeof") )
                
                    self.tv.isHidden = false
                
                  
                
               
                //debugPrint("json *1",first)
            case .failure(let value):
                print("errer",value)
            }
            
        }
        
        
       
        
    }
    @objc func refresh(_ sender: AnyObject) {
        tv.reloadData()
       // refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
        return size
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaults = UserDefaults.standard
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        
        let titre = contentView.viewWithTag(1) as! UILabel
        let date = contentView.viewWithTag(2) as! UILabel
       
        //let i = indexPath as Int
        //widgets setting value
        PostingViewModel.instance.FetchPostsByRecruiter(token:defaults.value(forKey: "recruitertoken") as! String , recruiter: defaults.value(forKey: "recruiterId") as! String){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                self.Js = json1
                self.sizeofjson = json1["call"].count
                let img = json1["call"][indexPath.row]["photo"].string
                if img != Optional(nil){
                    let  imageTV = contentView.viewWithTag(3) as! UIImageView
                    ImageLoader.shared.loadImage(
                     identifier: img!,
                        url: "http://localhost:3000/img/\(img!)",
                        completion: { image in
                            imageTV.image = image!
                            
                        })
                    titre.text = json1["call"][indexPath.row]["name"].string
                    date.text = json1["call"][indexPath.row]["dateBegin"].string
                }else{
                
                     
               
                titre.text = json1["call"][indexPath.row]["name"].string
                date.text = json1["call"][indexPath.row]["dateBegin"].string
                }
            case .failure(let value):
                print("errer",value)
            }
            
        }
        
       
      
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        let size = defaults.value(forKey: "sizeof") as! Int
        let indexx = indexPath.row
        if indexx > size {
            self.viewDidLoad()
        }else{
            performSegue(withIdentifier: "detail", sender: indexx)
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        if editingStyle == .delete{
            PostingViewModel.instance.FetchPostsByRecruiter(token:defaults.value(forKey: "recruitertoken") as! String , recruiter: defaults.value(forKey: "recruiterId") as! String){
                result in
                switch result {
                case .success(let json):
                    let json1 = JSON(json)
                    let callid = json1["call"][indexPath.row]["_id"].string!
                    defaults.setValue(json1["call"].count, forKey: "sizeof")
                    defaults.synchronize()
                    PostingViewModel.instance.removecall(callId:callid ){
                        result in
                        switch result {
                        case .success(_):
                        
                            defaults.synchronize()
                            let alert = UIAlertController(title: "success", message: "call deleted!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ok", style: .destructive){action ->Void in
                                self.viewDidLoad()
                                self.tv.reloadData()
                            }
                            alert.addAction(action)
                            self.present(alert , animated: true)
                            
                            
                        case .failure(let value):
                            let alert = UIAlertController(title: "failure", message: "cannot delete call!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                            alert.addAction(action)
                            self.present(alert , animated: true)
                            
                        }
                    }
                case .failure(let value):
                    print("errer",value)
                }
            }
        
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let indexx = sender as! Int
           
            let destination = segue.destination as! PostDetailViewController
            destination.index = indexx
        }
    }
    func fetchpostbyRecruiter(fid:String,ftoken:String)-> Int{
        PostingViewModel.instance.FetchPostsByRecruiter(token: ftoken, recruiter: fid){
            result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                debugPrint(json)
               
            case .failure(let value):
                print(value)
               
            }
        }
        return 1;
        
    }
    @IBAction func addTapped(_ sender: Any) {
       // let defaults = UserDefaults.standard
      //  performSegue(withIdentifier: "add", sender: nil)
       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "PostingRecruiterViewController") as! PostingRecruiterViewController
        //objSomeViewController.userId = defaults.value(forKey: "recruiterId")! as! String
        //objSomeViewController.token = defaults.value(forKey: "recruitertoken")! as! String
        self.navigationController?.pushViewController(objSomeViewController, animated: true)*/
    }
    
    
    @IBAction func refreshhed(_ sender: Any) {
        self.viewDidLoad()
    }
    

}
