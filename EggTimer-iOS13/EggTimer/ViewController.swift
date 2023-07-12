//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 3, "Medium": 5, "Hard": 7]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    @IBAction func hardnessSelected(_ sender: UIButton) {
        secondsPassed = 0
        timer.invalidate()
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        titleLabel.text = hardness
        
    }


        @objc func updateCounter() {
            //example functionality
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percent = Float(secondsPassed) / Float(totalTime)
                progressBar.progress = Float(percent)
                print(percent)
                
            }
            else{
                timer.invalidate()
                titleLabel.text = "Done"
            }
        }
    
    

}
