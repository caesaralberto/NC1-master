//
//  NextViewController.swift
//  CoolSter
//
//  Created by Caesar Alberto Fernandez on 21/05/19.
//  Copyright © 2019 Caesar Alberto Fernandez. All rights reserved.
//

import UIKit
import AVFoundation

class NextViewController: UIViewController {
    
    var audioPlayerNextPage = AVAudioPlayer()
    
    @IBOutlet weak var textLbl: UILabel!
    let shapeColor = [UIColor(displayP3Red: 2 / 255, green: 190 / 255, blue: 112 / 255, alpha: 1), UIColor(displayP3Red: 41 / 255, green: 94 / 255, blue: 164 / 255, alpha: 1), UIColor(displayP3Red: 250 / 255, green: 90 / 255, blue: 90 / 255, alpha: 1)]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            audioPlayerNextPage = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Winning", ofType: "mp3")!))
            audioPlayerNextPage.prepareToPlay()
            audioPlayerNextPage.numberOfLoops = 50
        }catch{
            print("error")
        }
        
        //gradation color initialization
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.init().shadeOrange.cgColor, UIColor.init().middleOrange.cgColor, UIColor.init().tintOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5,y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5,y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        textLbl.text = "Woohooo!!!"
        audioPlayerNextPage.play()
        spawnBall()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tap)))
    }
    
    @objc func tap() {
        dismiss(animated: true, completion: nil)
        audioPlayerNextPage.stop()
    }
    
    func spawnBall () {
        
        for _ in 1...80 {
            
            let randomX = Int.random(in: 0...400)
            let randomY = Int.random(in: 250...900)
            
            let shape = UIView(frame: CGRect(x: randomX, y: randomY, width: 25, height: 25))
            
            let _ = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                shape.layer.cornerRadius = shape.frame.width / 2
                UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
                    shape.backgroundColor = self.shapeColor.randomElement()
                }, completion: nil)
                
                
                let randPlaceX = CGFloat.random(in: 0...400)
                let randPlaceY = CGFloat.random(in: 250...900)
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
