//
//  NextViewController.swift
//  CoolSter
//
//  Created by Caesar Alberto Fernandez on 21/05/19.
//  Copyright © 2019 Caesar Alberto Fernandez. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var textLbl: UILabel!
    let shapeColor = [UIColor(displayP3Red: 250 / 255, green: 92 / 255, blue: 100 / 255, alpha: 1), UIColor(displayP3Red: 81 / 255, green: 180 / 255, blue: 144 / 255, alpha: 1), UIColor(displayP3Red: 46 / 255, green: 94 / 255, blue: 192 / 255, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gradation color initialization
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.init().shadeOrange.cgColor, UIColor.init().middleOrange.cgColor, UIColor.init().tintOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5,y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5,y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        textLbl.text = "Woohooooo"
        
        spawnBall()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tap)))
    }
    
    @objc func tap() {
        performSegue(withIdentifier: "homeVc", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    func spawnBall () {
        
        for _ in 1...80 {
            
            let randomX = Int.random(in: 0...400)
            let randomY = Int.random(in: 300...900)
            
            let shape = UIView(frame: CGRect(x: randomX, y: randomY, width: 25, height: 25))
            
            let _ = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                shape.layer.cornerRadius = shape.frame.width / 2
                UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
                     shape.backgroundColor = self.shapeColor.randomElement()
                }, completion: nil)
            
                
                let randPlaceX = CGFloat.random(in: 0...400)
                let randPlaceY = CGFloat.random(in: 300...900)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
                    shape.frame = CGRect(x: randPlaceX, y: randPlaceY, width: 25, height: 25)
                }) { (_) in
                    //
                }
            }
            self.view.addSubview(shape)
        }
    }
    
}
