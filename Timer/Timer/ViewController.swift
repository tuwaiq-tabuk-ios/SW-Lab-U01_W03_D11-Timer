//
//  ViewController.swift
//  Timer
//
//  Created by Shorouq AlAnzi on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
var counter = 30
let denteTime = 4.0 // 420
let normalTime = 6.0 // 660
var secondsPassed = 0.0
let totalTime = 0.0
var timer: Timer!
var player: AVAudioPlayer?
 
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    progressView.progress = 0.0
    questionLabel.text  = "How do you want to boil pasta?\nAl dente o normal"
  }
  
  @IBAction func boilingTypeSelected(_ sender: UIButton) {
    
    print("\nsender: \(sender.currentTitle!)")
    let boilingType = sender.currentTitle
    stopSound()
    if boilingType == "Dente" {
        progressView.progress = 0.0
        print("denteTime: \(denteTime)")
    questionLabel.text = "Boiling pasta al dente"
      secondsPassed = denteTime
    } else {
      print("normalTime: \(normalTime)")
      progressView.progress = 0.0
    questionLabel.text = "Boiling pasta normal"
      secondsPassed = normalTime
    }
timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(updateTimer),userInfo: nil, repeats: true)

    }
  @objc func updateTimer() {
    //example functionality
    progressView.setProgress(Float(secondsPassed), animated: true)
    if progressView.progress > 0 {
     print("\(secondsPassed) seconds to the end of the world")
      secondsPassed -= 1   } else {
      timer.invalidate()
    questionLabel.text = "TIME OVER!\nRemove pot from heat"
        playSound()
        
        let percentageProgress = (secondsPassed) / (totalTime)
        print("percentageProgress: \(percentageProgress)")
        progressView.progress = Float(percentageProgress)
  }
  }
  
  func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
          /* The following line is required for the player to work on
         iOS 11. Change the file type accordingly*/
          
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
          
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
  }
func stopSound(){
      player?.stop()
    }
}
  

