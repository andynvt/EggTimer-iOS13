//
//  ViewController.swift
//  EggTimer
//
//  Created by ANDY on 13/08/2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondPassed = 0
    
    var timer = Timer()
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        
        progressBar.progress = 0.0
        secondPassed = 0
        label.text = hardness
        
    
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(secondPassed < totalTime) {
            secondPassed += 1
            let percent = Float(secondPassed) / Float(totalTime)
            progressBar.progress = percent
        } else {
            timer.invalidate()
            label.text = "Done"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
