//
//  ViewController.swift
//  TimerProject
//
//  Created by rasha  on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  
  @IBOutlet weak var QuostionLable: UILabel!
  
  
  
  @IBOutlet weak var progressView: UIProgressView!
  let denteTime = 4
  let normalTime = 6
  
  var secondsLeft = 0
  var timer : Timer = Timer()
  var player: AVAudioPlayer?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    progressView.progress = 0.0
    
  }
  
  
  
  @IBAction func boilingTypeTressd(_ sender: UIButton) {
    //print("sender:\(sender.currentTitle)")
    let boilingTypeTressd = sender.currentTitle!
    stopSound()
    //print(boilingTypeTressd)
    if boilingTypeTressd == "normal" {
      secondsLeft = normalTime
      progressView.progress = 0.0
      QuostionLable.text = "Boiling pasta normal time"
    }else{
      secondsLeft = denteTime
      progressView.progress = 0.0
      QuostionLable.text = "Boiling pasta dente time "
    }
    Timer.scheduledTimer(timeInterval: 1.0,
                         target: self,
                         selector: #selector(ubdateCounter),
                         userInfo: nil,
                         repeats: true)
  }
  
  
  
  
  
  
  
  
  
  
  
  @objc func ubdateCounter(){
    
    stopSound()
    //example functionality
    if secondsLeft > 0 {
      progressView.setProgress(Float((secondsLeft)),
                               animated: true)
      print("\(secondsLeft) seconds to the end of the world")
      secondsLeft -= 1
    } else {
      timer.invalidate()
      QuostionLable.text = "TIME IS OVER!\nRemove pot from heat"
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
  
  func stopSound(){
    player?.stop()
  }
}
