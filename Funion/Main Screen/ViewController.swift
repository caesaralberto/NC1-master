//
//  ViewController.swift
//  CoolSter
//
//  Created by Caesar Alberto Fernandez on 17/05/19.
//  Copyright © 2019 Caesar Alberto Fernandez. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

extension UIColor{
    var shadeOrange: UIColor {return UIColor(displayP3Red: 255 / 255, green: 171 / 255, blue: 27 / 255, alpha: 1)}
    var middleOrange: UIColor {return UIColor(displayP3Red: 255 / 255, green: 196 / 255, blue: 14 / 255, alpha: 1)}
    var tintOrange: UIColor {return UIColor(displayP3Red: 254 / 255, green: 203 / 255, blue: 80 / 255, alpha: 1)}
    var roundOneColor: UIColor {return UIColor(displayP3Red: 2 / 255, green: 190 / 255, blue: 112 / 255, alpha: 1)}
}

class ViewController: UIViewController {
    var audioPlayerOne = AVAudioPlayer()
    var audioPlayerTwo = AVAudioPlayer()
    //set rgb value roundOne
    var redOne: Float = 255/255
    var greenOne: Float = 255/255
    var blueOne: Float = 255/255
    
    //for unwind segue
    @IBAction func backVc(_ sender: UIStoryboardSegue){
    }
    
    //declare label text
    @IBOutlet weak var orderLbl: UILabel!{
        didSet{
            orderLbl.text = ""
        }
    }
    
    //declare round view one
    @IBOutlet weak var colorOne: UIView!{
        didSet{
            colorOne.layer.cornerRadius = colorOne.frame.width / 2
            //            colorOne.layer.borderWidth = 5
            //            colorOne.layer.borderColor = #colorLiteral(red: 1, green: 0.3921714723, blue: 0.396386385, alpha: 1)
        }
    }
    
    //declare one view front color onwe
    @IBOutlet weak var backgroundView: UIView!{
        didSet{
            backgroundView.layer.cornerRadius = backgroundView.frame.width / 2
            //            backgroundView.layer.borderWidth = 5
            //            backgroundView.layer.borderColor = #colorLiteral(red: 1, green: 0.3921714723, blue: 0.396386385, alpha: 1)
        }
    }
    
    //declare before appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            audioPlayerOne = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Pop", ofType: "mp3")!))
            audioPlayerOne.prepareToPlay()
            
            audioPlayerTwo = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "drum roll", ofType: "mp3")!))
            audioPlayerTwo.prepareToPlay()
            audioPlayerTwo.numberOfLoops = 50
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
        
        //declare asset before appear
        colorOne.isHidden = false
        backgroundView.isHidden = false
        orderLbl.isHidden = false
        orderLbl.alpha = 1
        backgroundView.layer.backgroundColor = UIColor.init().roundOneColor.cgColor
        colorOne.layer.backgroundColor = UIColor.init().roundOneColor.cgColor
        
        //set view to beginning
        colorOne.transform = .identity
        backgroundView.gestureRecognizers = .init()
        backgroundView.transform = .identity
        
        //when view one isClicked
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tap)))
        
    }
    
    //function round one tap
    @objc func tap(){
        
        //show animation change color shape one
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundView.backgroundColor = UIColor(displayP3Red: CGFloat(self.redOne), green: CGFloat(self.greenOne), blue: CGFloat(self.blueOne), alpha: 1)
            self.audioPlayerOne.play()
        }) { (_) in
            
            //show animation change label name
            UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
                self.orderLbl.text = "3"
                self.orderLbl.alpha = 0
                self.backgroundView.isUserInteractionEnabled = false
                self.audioPlayerTwo.play()
                
            }) { (_) in
                UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
                    self.orderLbl.alpha = 1
                    self.orderLbl.text = "2"
                    self.backgroundView.isUserInteractionEnabled = false
                    self.orderLbl.alpha = 0
                }) { (_) in
                    UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
                        self.orderLbl.alpha = 1
                        self.orderLbl.text = "1"
                        self.backgroundView.isUserInteractionEnabled = false
                        self.orderLbl.alpha = 0
                        
                    }) { (_) in
                        //play animate after label "wait" show
                        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                            self.backgroundView.isUserInteractionEnabled = true
                            self.orderLbl.text = "Hold"
                            self.orderLbl.alpha = 1
                            
                        }) { (_) in
                        }
                    }
                    
                }
            }
        }
        
        //show animation round will moving and scaling
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            let scaling = CGAffineTransform(scaleX: 2, y: 2)
            let translating = CGAffineTransform(translationX: 0, y: 80)
            
            self.colorOne.alpha = 1.0
            self.colorOne.transform = CGAffineTransform(scaleX: 50, y: 50)
            self.backgroundView.alpha = 1.0
            self.backgroundView.transform = scaling.concatenating(translating)
            
        }) { (_) in
            
        }
        
        //after finished round can be touch for other function
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.changeColor))
        tapGesture.minimumPressDuration = 0
        self.backgroundView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func changeColor(gestureRecognizer: UILongPressGestureRecognizer){
        
        //when hold view condition
        if gestureRecognizer.state == .changed {
            //when alpha of backgorundView less than 0
            if backgroundView.alpha > 0 {
                
                //vibrate when press
                AudioServicesPlaySystemSound(1520)
                
                //reduce alpha of background view
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    self.backgroundView.alpha -= 0.1
                }) { (_) in
                    //
                }
            }else {
                //go to next page
                performSegue(withIdentifier: "nextVc", sender: self)
                self.orderLbl.text = ""
                self.backgroundView.alpha = 1
                self.colorOne.alpha = 1
                self.audioPlayerTwo.stop()
                
            }
        }
    }
}

