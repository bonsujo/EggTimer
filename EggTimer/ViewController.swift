//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
// Modified and edited in accordance, Josephine Bonsu

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
    var player: AVAudioPlayer!
    
    @IBOutlet weak var eggTimerUp: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    
    // creting variables to keep track of time in seconds 
    var totalTime = 0
    var secondPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //stops timer each time user selected hardness button
        timer.invalidate()
        let hardness = sender.currentTitle! //getting the hardeness label
        totalTime = eggTimes[hardness]! // setting total time equal to the value of eggTimes dictionary key
        //used for resetting values when hardness is selected
        eggProgress.progress = 0.0
        secondPassed = 0
        eggTimerUp.text = hardness
        
        // timer of a time interval of 1 second, uses updateTimer method each second, repeats till seconds are up
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
            
    }

    //updates timer each second that passes
    @objc func updateTimer(){
        if secondPassed < totalTime {

            secondPassed += 1
            
            eggProgress.progress = Float(secondPassed) / Float(totalTime)
            
        } else{
            //stops timer when seconds passed e is less than total time
            timer.invalidate()
            eggTimerUp.text = "TIMES UP!⏱"
            playSound()
        }
 
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
    

