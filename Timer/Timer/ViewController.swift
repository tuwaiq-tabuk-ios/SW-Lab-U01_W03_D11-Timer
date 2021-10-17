//
//  ViewController.swift
//  Timer
//
//  Created by Ahmed awadh alqhtani on 11/03/1443 AH.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
  var player: AVAudioPlayer?
  
  var progressTimer: Timer!
  let dentTime = 4.0
  let normalTime = 6.0
  var scoundLift = 0.0
  
  
  @IBOutlet weak var labelButton: UILabel!
  
  @IBOutlet weak var timer: UIProgressView!
  override func viewDidLoad() {
    super.viewDidLoad()
    timer.progress = 0.0
    
    
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func liftButton(_ sender: Any) {
    
    labelButton.text = "Boiling pasta al dente"
    scoundLift = dentTime
    timer.progress = 0.0
    if (self.progressTimer != nil) {
      progressTimer.invalidate()
    }
    self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCounter),
                                              userInfo: nil,
                                              repeats: true)
  }
  
  
  @IBAction func RightButton(_ sender: Any) {
    labelButton.text = "Boiling pasta al Normal"
    scoundLift = normalTime
    timer.progress = 0.0
    if (self.progressTimer != nil) {
      progressTimer.invalidate()
    }
    self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCounter),
                                              userInfo: nil,
                                              repeats: true)
    
  }
  
  
  
  
  
  
  @objc func updateCounter() {
    
    //example functionality
    timer.progress = 0.0
    stopSound()
    if scoundLift > 0 {
      timer.setProgress(Float(scoundLift), animated: true)
      print("\(scoundLift) seconds to the end of the world")
      scoundLift -= 1
    }else {
      labelButton.text = "TIME IS OVER! \n Remove pot from heat"
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
    player?.stop()
  }
}
