//
//  ViewController.swift
//  Timer_App
//
//  Created by عبدالعزيز البلوي on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var progressView: UIProgressView!
  
  @IBOutlet weak var percentageLabel: UILabel!
  
  
  var player: AVAudioPlayer?
  
  
  let denteTime = 420.0
  let normalTime = 660.0
  var secondsLeft = 0.0
  var totelTimer = 0.0
  var secondsPassed = 0.0
  var timer : Timer!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progressView.progress = 0.0
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    let bolingType = sender.currentTitle!
    stopSound()
    if bolingType == "Normal"{
      secondsLeft = normalTime
      secondsPassed = 0
      totelTimer = normalTime
      progressView.progress = 0.0
      percentageLabel.text = "0%"
      questionLabel.text = "Boiling pasta  normal time"
    }else{
      secondsLeft = denteTime
      secondsPassed = 0
      totelTimer = denteTime
      percentageLabel.text = "0%"
      progressView.progress = 0.0
      questionLabel.text = "Boiling pasta  dente time"
    }
    timer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector:#selector(updateCounter),userInfo: "Dente",repeats: true)
  }
  
  
  
  @objc func updateCounter() {
    //example functionality
    secondsPassed += 1
    
    
    if secondsLeft > 0 {
      let percentageProgress = secondsPassed / totelTimer
      percentageLabel.text = "\(Int(percentageProgress * 100))%"
      progressView.progress = Float(percentageProgress)
      print("\(secondsLeft) seconds to the end of the world")
      secondsLeft -= 1
    }else{
      timer.invalidate()
      questionLabel.text = "TIME IS OVER! \n Remove pot from heat"
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









