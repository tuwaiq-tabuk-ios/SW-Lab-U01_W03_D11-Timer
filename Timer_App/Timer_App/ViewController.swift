//
//  ViewController.swift
//  Timer_App
//
//  Created by محمد العطوي on 11/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var questiOnLabel:UILabel!
    
    @IBOutlet weak var waitingTime: UIProgressView!
    
    var player: AVAudioPlayer?
    var isStart = false
    
    var counter = 30.0
    var progressTimer:Timer!
    //var timer:Timer = Timer()

    let denteTime = 420.0
    let normalTime = 660.0 
    var sucoundLift = 0.0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        waitingTime.progress = 0.0
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func boilingTypeSelected(_ sender: UIButton) {
        
        print("\nsender: \(sender.currentTitle!)")
        
        if isStart {
            progressTimer.invalidate()
            isStart = !isStart
        }
        
        let boilingType = sender.currentTitle!
        
        if boilingType == "Dente" {
            print("denteTime: \(denteTime)")
            questiOnLabel.text = "Boiling pasta al dente"
            sucoundLift = denteTime
            waitingTime.progress = 0.0
            stopSound ()
            isStart = true
        } else{
            
            print("normalTime: \(normalTime)")
            questiOnLabel.text = "Boiling pasta normal time"
            sucoundLift = normalTime
            waitingTime.progress = 0.0
            stopSound()
            isStart = true

        }
    
        
        progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        
        
        
        
        
        
        
        
        /* @IBAction func liftButton(_ sender: UIButton) {
         
         questiOnLabel.text = "Boiling pasta al Dente "
         sucoundLift = denteTime
         waitingTime.progress = 0.0
         self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
         stopSound()
         }
         
         
         @IBAction func rightButton(_ sender: UIButton) {
         
         questiOnLabel.text = "Boiling pasta al normal "
         sucoundLift = normalTime
         waitingTime.progress = 0.0
         self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
         stopSound()
         }*/
        
    }
    
    
    @objc func updateCounter() {
        //example functionality
        
        if sucoundLift > 0 {
            waitingTime.setProgress(Float(sucoundLift), animated: true)
            print("\(sucoundLift) seconds to the end of the world")
            sucoundLift -= 1
        }else{
            questiOnLabel.text = "TIME is OVER Remove pot from heat"
            progressTimer.invalidate()
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func stopSound () {
        player?.stop()
    }
    
}



