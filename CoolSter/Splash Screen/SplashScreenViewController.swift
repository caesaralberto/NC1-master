//
//  SplashScreenViewController.swift
//  CoolSter
//
//  Created by Caesar Alberto Fernandez on 22/05/19.
//  Copyright © 2019 Caesar Alberto Fernandez. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashScreenImage: UIImageView!
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.7, options: [.curveEaseInOut], animations: {
            let rotate = CGAffineTransform(rotationAngle: 45 * 3)
            
            self.splashScreenImage.transform = rotate
        }) { (finished) in
            UIView.animate(withDuration: 1, delay: 0, options: [.transitionCrossDissolve], animations: {

                let scale = CGAffineTransform(scaleX: 50, y: 50)
                
                self.splashScreenImage.transform = scale
                
            }) { (finished) in
      
                let targetVc = UIStoryboard(name: "Main", bundle: nil)
                let currVc = targetVc.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = currVc
            }
        }
    }
}
