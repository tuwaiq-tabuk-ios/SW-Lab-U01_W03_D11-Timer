//
//  ViewController.swift
//  Timer_App
//
//  Created by عبدالعزيز البلوي on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var textTimer: UILabel!
  @IBOutlet weak var timer: UIProgressView!
  
  var player: AVAudioPlayer?
  var progressTimer:Timer!
  
  var denteTime = 420.0
  var normalTime = 660.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    timer.progress = 0.0
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func lleftButton(_ sender: UIButton) {
    textTimer.text = "Boiling pasta al dente"
    denteTime = 420.0
    stopSound()
    self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector:#selector(updateCounter),userInfo: "Dente",repeats: true)
  }
  
  @IBAction func rightButton(_ sender: UIButton) {
    textTimer.text = "Boiling pasta al normal"
    normalTime = 660.0
    stopSound()
    self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector:#selector(updateCounter),userInfo: "Normal",repeats: true)
  }
  
  
  @objc func updateCounter() {
    //example functionality
    timer.progress = 0.0
    let name = progressTimer.userInfo as! String
    if name == "Dente" {
      if denteTime > 0 {
        timer.setProgress(Float(denteTime), animated: true)
        
        print("\(denteTime) seconds to the end of the world")
        denteTime -= 1
      }else{
        textTimer.text = "TIME IS OVER! \n Remove pot from heat"
        progressTimer.invalidate()
        playSound()
        
      }
    }else{
      if normalTime > 0 {
        timer.setProgress(Float(normalTime), animated: true)
        
        print("\(normalTime) seconds to the end of the world")
        normalTime -= 1
      }else{
        textTimer.text = "TIME IS OVER! \n Remove pot from heat"
        progressTimer.invalidate()
        playSound()
        
      }
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
