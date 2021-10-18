//
//  ViewController.swift
//  Timer
//
//  Created by Ameera BA on 17/10/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  let normalTime  = 620 //11min , 6
  let denteTime = 420 //7min , 4
  
  
  var secondsLeft = 0
  var timer:Timer = Timer()
  var secondsPassed = 0
  var totalTime = 0
  var player: AVAudioPlayer?
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progresView: UIProgressView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progresView.progress = 0.0
  }
  
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    
    print("\nsender: \(sender.currentTitle!)")
    
    timer.invalidate()
    
    questionLabel.text = "How do you want to boil pasta? \n Al dente or regular"
    
    let boilingType = sender.currentTitle!
    
    if boilingType == "Dente"{
      print("denteTime: \(denteTime)")
      questionLabel.text = "Boiling pasta al dente"
      secondsLeft = denteTime
      progresView.progress = 0.0
    } else {
      print("normalTime: \(normalTime)")
      questionLabel.text = "Boiling pasta normal"
      secondsLeft = normalTime
      progresView.progress = 0.0
    }
   
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector : #selector(updateTimer) ,
                                 userInfo: nil,
                                 repeats: true)
    stopSound()
    }
  
  
  func showTheButtonMessage(message : String){
    questionLabel.text = message
  }
  
  
  @objc func updateTimer(){
    
    if secondsLeft > 0 {
      progresView.setProgress(Float(secondsLeft), animated: true)
      print("secondsPassed: \(secondsLeft)")
      secondsLeft -= 1
    } else {
      timer.invalidate()
      questionLabel.text = "TIME IS OVER! \nRemove pot from heat"
      playSound(soundName: "alarm")
    }
  }
  
  
  func playSound(soundName: String) {
    guard let url = Bundle.main.url(forResource: soundName , withExtension: "mp3")
    else { return
      
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else {
        return
        }
      
      player.play()
      
    } catch let error {
      print("ERROR: The audio does not work.\n \(error.localizedDescription)")
    }
  }
  
  
  func stopSound() {
    player?.stop()
  }
}

