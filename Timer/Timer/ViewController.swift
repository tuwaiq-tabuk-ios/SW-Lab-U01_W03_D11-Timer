//
//  ViewController.swift
//  Timer
//
//  Created by bushra nazal alatwi on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var denteTime = 4
    var normalTime = 6
    
    var secondsLeft = 0
    
    var timer : Timer!
    
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
    }
    

    @IBAction func boilingTypePressed(_ sender: UIButton) {
        //print("sender: \(sender.currentTitle)")
        let boilingType = sender.currentTitle!
        
        stopSound()
        
        if boilingType == "Normal" {
           secondsLeft = normalTime
           progressView.progress = 0.0
            questionLabel.text = "Boiling pasta normal time "
            }else{
           secondsLeft = denteTime
           progressView.progress = 0.0
            questionLabel.text = "Boiling pasta dente time "
            }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
@objc func updateTimer() {
    if secondsLeft > 0 {
        progressView.setProgress(Float(secondsLeft), animated: true)
        print("secondLift:\(secondsLeft) ")
        secondsLeft -= 1
            } else {
        timer.invalidate()
        questionLabel.text = "TIME IS OVER!\nRemove pot from heat"
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
        player?.stop()

    }
}
