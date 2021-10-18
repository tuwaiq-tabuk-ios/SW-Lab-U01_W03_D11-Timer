//
//  ViewController.swift
//  TimerApp-itr1
//
//  Created by Aisha Ali on 10/17/21.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
  
  var cookingTimer:Timer = Timer()
  let denteTime: Int = 4    // 420
  let normalTime: Int = 6   // 660
  var secondsLeft = 0
  var player:AVAudioPlayer?
  var secondsPassed = 0
  var totalTime = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBOutlet weak var quetionLabel: UILabel!
  
  
  @IBOutlet weak var timer: UIProgressView!
  
  
  @IBAction func boilingTypeSelected(_ sender: UIButton) {
    print("\nsender: \(sender.currentTitle!)")
    cookingTimer.invalidate()
    let boilingType = sender.currentTitle!
    if boilingType == "Dente" {
      print("denteTime: \(denteTime)")
      quetionLabel.text = "Boilling pasta al dente"
      secondsLeft = denteTime
    } else {
      print("normalTime: \(normalTime)")
      quetionLabel.text = "Boilling pasta normal time"
      secondsLeft = normalTime
    }
    cookingTimer = Timer.scheduledTimer(timeInterval: 1.00
                                        , target: self
                                        , selector: #selector(updateTimer)
                                        , userInfo: nil
                                        , repeats: true)
    self.timer.setProgress(0, animated: false)
    player?.stop()
  }
  
  
  @objc func updateTimer (){
    totalTime = secondsLeft
    if secondsLeft > 0 {
      secondsPassed = secondsLeft
      let percentageProgress = (secondsPassed/totalTime)*100
      print("percentageProgress: \(percentageProgress)")
      timer.progress = Float(percentageProgress)
      
      timer.setProgress(Float(secondsLeft), animated: true)
      print("\(secondsLeft) seconds.")
      secondsLeft -= 1
      
    }else {
      playSound(soundName: "alarm")
      cookingTimer.invalidate()
      quetionLabel.text = "TIME IS OVER! \n Remove pot from heat "
    }
  }
  
  
  func playSound(soundName: String) {
    guard let url =
            Bundle.main.url(forResource: soundName,
                            withExtension: "mp3") else {
      return
    }
    
    do {
      try AVAudioSession.sharedInstance()
        .setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance()
        .setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url)
      
      guard let player = player else {
        return
      }
      
      player.play()
      
    } catch let error {
      print("ERROR: The audio does not work.\n\(error.localizedDescription)")
    }
  }
}

