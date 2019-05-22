//
//  BallController.swift
//  CoolSter
//
//  Created by Caesar Alberto Fernandez on 20/05/19.
//  Copyright © 2019 Caesar Alberto Fernandez. All rights reserved.
//

import UIKit

class BallController: UIViewController {

    func balls() {
        for _ in 1...100 {
            shape.backgroundColor = shapeColor.randomElement()
            shape.layer.cornerRadius = shape.frame.width / 2
            
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .curveEaseIn], animations: {
                shape.frame = CGRect(x: CGFloat.random(in: 50...350), y: CGFloat.random(in: 500...800), width: 25, height: 25)
            }, completion: nil)
            
            self.view.addSubview(shape)
        }
    }
}
