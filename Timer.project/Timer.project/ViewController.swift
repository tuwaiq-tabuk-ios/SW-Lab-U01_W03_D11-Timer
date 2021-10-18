//
//  ViewController.swift
//  Timer.project
//
//  Created by ABRAR ALQARNI on 11/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressview: UIProgressView!
    
    let denteTime = 4
    let  normalTime = 6
    var secondsLeft = 0
    var timer : Timer!
    var player: AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressview.progress = 0.0
    }
    
    //   الزر الاول والثاني
    @IBAction func boilingTypePresse(_ sender: UIButton) {
        let  boilingType = sender.currentTitle!
        stopAudio()
        if boilingType == "Normal" {
            secondsLeft = normalTime
            progressview.progress = 0.0
            questionLabel.text = "Boiling Pasta 🍝 Normal Time 😍"
            
            
        }else{
            secondsLeft = denteTime
            progressview.progress = 0.0
            questionLabel.text = "Boiling Pasta 🍝 Dente Time 😍"
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondsLeft > 0 {
            progressview.setProgress(Float(secondsLeft), animated: true)
            print("\(secondsLeft) seconds to the end of the world")
            secondsLeft -= 1
        }else{
            timer.invalidate()
            questionLabel.text = "TIME IS OVER!\nYour Pasta is ready "
            playSound()
            
            
        }
    }
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func stopAudio(){
        player?.stop()
    }
}
