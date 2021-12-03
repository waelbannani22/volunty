//
//  MyPostsViewController.swift
//  volunty
//
//  Created by wael bannani on 13/11/2021.
//

import UIKit
import SwiftyJSON

class MyPostsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
  
    
   
    

    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    
    @IBOutlet weak var refresh: UIButton!
    var sizeofjson :Int?
    var Js : JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.synchronize()
        namelabel.text! = defaults.value(forKey: "name") as! String
        tv.reloadData()
        self.viewWillAppear(true)
        

        self.loadViewIfNeeded()
     
        
        PostingViewModel.instance.FetchPostsByRecruiter(token:defaults.value(forKey: "recruitertoken") as! String , recruiter: defaults.value(forKey: "recruiterId") as! String){
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                self.Js = json1
                self.sizeofjson = json1["call"].count
               // print(json1["call"].count)
                
              
              //  print(self.sizeofjson!)
               // print("first",self.Js?["call"][0]["name"])
                defaults.setValue(json1["call"].count, forKey: "sizeof")
                defaults.synchronize()
                print("default",defaults.value(forKey: "sizeof") )
               
                //debugPrint("json *1",first)
            case .failure(let value):
                print("errer",value)
            }
        }
        
       
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        return  defaults.value(forKey: "sizeof") as! Int
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
               
                     
               
                titre.text = json1["call"][indexPath.row]["name"].string
                date.text = json1["call"][indexPath.row]["dateBegin"].string
            
            case .failure(let value):
                print("errer",value)
            }
        }
        
       
      
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexx = indexPath.row
        performSegue(withIdentifier: "detail", sender: indexx)
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
        let defaults = UserDefaults.standard
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewController(withIdentifier: "PostingRecruiterViewController") as! PostingRecruiterViewController
        objSomeViewController.userId = defaults.value(forKey: "recruiterId")! as! String
        objSomeViewController.token = defaults.value(forKey: "recruitertoken")! as! String
        self.navigationController?.pushViewController(objSomeViewController, animated: true)
    }
    
    
    @IBAction func refreshhed(_ sender: Any) {
        self.viewDidLoad()
    }
    

}
