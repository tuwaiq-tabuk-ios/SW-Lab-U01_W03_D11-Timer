//
//  ViewController.swift
//  Timer
//
//  Created by azooz alhwiti on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
   
    let denteTime: Int = 420 // 360
    let normalTime: Int = 660 // 660
    var secondsLeft = 0
    var timer: Timer  = Timer()
    var player: AVAudioPlayer?


    @IBOutlet weak var progressView: UIProgressView!
    var counter = 30

    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
    }


    @IBAction func boilingTypePressed(_ sender: UIButton) {
      print("\nsender: \(sender.currentTitle!)")
      timer.invalidate()
      let boilingType = sender.currentTitle!
      if boilingType == "Dente" {
        print("denteTime: \(denteTime)")
    questionLabel.text = "Hirviendo pasta al dente"
    secondsLeft = denteTime
    progressView.progress = 0.0
    } else {
      print("normalTime: \(normalTime)")
    questionLabel.text = "Hirviendo pasta normal"
      secondsLeft = normalTime
    progressView.progress = 0.0
    }
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
    }
    
    
    @objc func updateTimer() {
      //example functionality
      if secondsLeft > 0 {
      print("secondsLeft: \(secondsLeft)")
        progressView.setProgress(Float(secondsLeft), animated: true)
      secondsLeft -= 1
    }
    else {
      timer.invalidate()
    questionLabel.text = "TIEMPO FINALIZADO!\nRemove pot from heat"
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
    
}

