//
//  ViewController.swift
//  pasta timing
//
//  Created by Yousef Albalawi on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  var counter = 30
  let denteTime = 4.0
  let normalTime = 6.0
  
  var scoundLift = 0.0
  var player: AVAudioPlayer?
  
  var progressTimer: Timer!
  var isStart = false
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progress: UIProgressView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progress.progress = 0.0
    //    Timer.scheduledTimer(timeInterval: 1.0,
    //                         target: self,
    //                         selector: #selector(updateCounter),
    //                         userInfo: nil,
    //                         repeats: true)
  }
  
  
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    let name = "\(String(describing: sender.title(for: .normal)!))"
    print("Sender: \(String(describing: sender.title(for: .normal)))")
    
    if isStart {
      progressTimer.invalidate()
    }
    
    if name == "Dente"{
      scoundLift = denteTime
      questionLabel.text = "Boiling pasta al dente"
      progress.progress = 0.0
    }else{
      scoundLift = normalTime
      questionLabel.text = "Boiling pasta al normal"
      progress.progress = 0.0
    }

    isStart = true
    self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCounter),
                                              userInfo: nil,
                                              repeats: true)
  }
  
  @objc func updateCounter() {
    //example functionality
    stopSound()
      if scoundLift > 0 {
        progress.setProgress(Float(scoundLift), animated: true)
        print("\(scoundLift) scound to the end of the world")
        scoundLift -= 1
      }else{
        questionLabel.text = "TIME IS OVER Remove pot from haet"
        progressTimer.invalidate()
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


