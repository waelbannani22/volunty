//
//  volunteerQrViewController.swift
//  volunty
//
//  Created by wael bannani on 26/12/2021.
//

import UIKit

class volunteerQrViewController: UIViewController {

    @IBOutlet weak var qrImage: UIImageView!
    var combined : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        qrImage.image = generateQRCode(from: combined!)
        
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {return nil}
            
            let transformScale = CGAffineTransform(scaleX: 5.0, y: 5.0)
            let scaledQRImage = QRImage.transformed(by: transformScale)
            
            return UIImage(ciImage: scaledQRImage)
        }
        return nil
    }
    

  

}
