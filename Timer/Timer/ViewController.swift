//
//  ViewController.swift
//  Timer
//
//  Created by روابي باجعفر on 11/03/1443 AH.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var progressView: UIProgressView!
  
  let denteTime = 4
  let normalTime  = 6
  
  var secondsLeft = 0
  
  var timer: Timer = Timer()
  
  var player: AVAudioPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progressView.progress = 0.0
  }
  
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    // print("\nsender: \(sender.currentTitle!)")
    let boilingType = sender.currentTitle!
    
    timer.invalidate()
    stopSound()
    
    if boilingType == "Normal" {
      secondsLeft = normalTime
      progressView.progress = 0.0
      questionLabel.text = "Boiling pasta normal time"
      
    } else{
      secondsLeft = denteTime
      progressView.progress = 0.0
      questionLabel.text = "Boiling pasta dente time"
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
      progressView.setProgress(Float(secondsLeft), animated: true)
      print("Seconds left: \(secondsLeft)")
      secondsLeft -= 1
    } else{
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
  
  func stopSound() {
    player?.stop()
  }
}


