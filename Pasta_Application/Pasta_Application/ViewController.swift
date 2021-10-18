//
//  ViewController.swift
//  Pasta_Application
//
//  Created by Mohammed on 11/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    let denteTime = 4.0
    let normalTime = 6.0
    var secondLeft = 0.0
    var progressTimer: Timer!
    
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerProgress.progress = 0.0
        // Do any additional setup after loading the view.
    }

    
    @IBAction func boilingTypePressed(_ sender: UIButton) {
        
        print("sender: \(String(describing: sender.currentTitle))")
        
        if sender.currentTitle == "Dente" {
            
        } else {
            
        }
    
        
     textMessage.text = "Boiling pasta al dente"
        secondLeft = denteTime
        timerProgress.progress = 0.0
        stopSound()
        self.progressTimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter),userInfo:nil, repeats: true)
    }
    
    @objc func updateCounter (){
        timerProgress.progress = 0.0
       stopSound()
            if secondLeft > 0 {
                timerProgress.setProgress(Float(secondLeft), animated: true)
                print("\(secondLeft) seconds to the end of the world")
                secondLeft -= 1
            }else{
                textMessage.text = "TIME IS OVER! \n Remove pot from the heat"
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
        func stopSound() {
            player? .stop()
    }

}
