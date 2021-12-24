//
//  EmergencyCaseViewController.swift
//  volunty
//
//  Created by wael bannani on 8/11/2021.
//

import UIKit
import SwiftyJSON
import Braintree
class EmergencyCaseViewController: UIViewController, BTAppSwitchDelegate , BTViewControllerPresentingDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    //var
    var index :Int?
    //widgets
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var name: UILabel!
   
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var PAY: UIButton!
    override func viewDidLoad() {
        //paypal
       
        //
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
                //self.target.text = json1["donation"][self.index!]["montantTotal"].string
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
    
    @IBAction func paypal(_ sender: Any) {
        print("payment")
        var braintreeClient: BTAPIClient?
            // Example: Initialize BTAPIClient, if you haven't already
            braintreeClient = BTAPIClient(authorization: "sandbox_v2k33s6w_2b94czwzxvvjjp3d")!
    
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
       
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional

            // Specify the transaction amount here. "2.32" is used in this example.
            let request = BTPayPalRequest(amount: "2.32")
            request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                    // Access additional information
                    let email = tokenizedPayPalAccount.email
                    print("email",email!)
                    let firstName = tokenizedPayPalAccount.firstName
                    let lastName = tokenizedPayPalAccount.lastName
                    let phone = tokenizedPayPalAccount.phone

                    // See BTPostalAddress.h for details
                    let billingAddress = tokenizedPayPalAccount.billingAddress
                    let achat = tokenizedPayPalAccount.nonce
                    print(achat)
                    let shippingAddress = tokenizedPayPalAccount.shippingAddress
                    self.performSegue(withIdentifier: "donnation", sender: nil)
                    
                } else if let error = error {
                    
                } else {
                    // Buyer canceled payment approval
                }
            }
    }
    
    
  
    
    
}
