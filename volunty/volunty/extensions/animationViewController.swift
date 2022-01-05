//
//  animationViewController.swift
//  volunty
//
//  Created by wael bannani on 25/12/2021.
//

import UIKit

class animationViewController: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.3)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations:{
            self.transform = CGAffineTransform.identity
            
        } ,completion: nil)
        super.touchesBegan(touches, with: event)
    }
    

   

}
