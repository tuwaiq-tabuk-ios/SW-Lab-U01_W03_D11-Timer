//
//  ViewController.swift
//  Timer
//
//  Created by Marzouq Almukhlif on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var normalImageView: UIImageView!
  @IBOutlet weak var denteImageView: UIImageView!
  
  
  var timer: Timer!
  var timeRemaining: Float!
  var isStart = false
  var player: AVAudioPlayer?
  let denteTime = 4.0
  let normalTime = 6.0
  var secondsLeft = 0.0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    progressView.progress = 0.0
    progressView.layer.cornerRadius = 10
    progressView.clipsToBounds = true
    progressView.layer.sublayers![1].cornerRadius = 10
    progressView.subviews[1].clipsToBounds = true
  }
  
  
  
  #imageLiteral(resourceName: "simulator_screenshot_A366EC4D-C715-40C8-827E-E641CA9933FE.png")
  @IBAction func boilingTypeSelected(_ sender: UIButton) {
    let boilingType = sender.currentTitle
    stopAlarm()
    if boilingType == "Normal" {
      questionLabel.text = "Boiling pasta al normal."
      secondsLeft = normalTime
      normalStart()
    }else{
      questionLabel.text = "Boiling pasta al dente."
      secondsLeft = denteTime
      denteStart()
    }
  }
  
  
  
  
  
  
  func denteStart() {
    if isStart {
      timer.invalidate()
      UIView.animate(withDuration:2.0, animations: {
        self.normalImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
      })
    }
    
    isStart = true
    progressView.progress = 0.0
    self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector:
                                                #selector(ViewController.updateProgressView),
                                              userInfo: denteImageView,
                                              repeats: true)
  }
  
  func normalStart() {
    if(isStart){
      timer.invalidate()
      UIView.animate(withDuration:2.0, animations: {
        self.denteImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
      })
    }
    
    isStart = true
    progressView.progress = 0.0
    self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector:
                                                #selector(ViewController.updateProgressView),
                                              userInfo: normalImageView,
                                              repeats: true)
  }
  
  
  
  @objc func updateProgressView(){
    let image = timer.userInfo as! UIImageView
    print(Float(secondsLeft))
    secondsLeft -= 1
    
    if secondsLeft > 0 {
      UIView.animate(withDuration:2.0, animations: { [self] in
        image.transform = CGAffineTransform(rotationAngle: CGFloat(90 + secondsLeft))
      })
      progressView.setProgress(Float(secondsLeft), animated: true)
      
    }else {
      UIView.animate(withDuration:2.0, animations: {
        image.transform = CGAffineTransform(rotationAngle: CGFloat(0))
      })
      timer.invalidate()
      questionLabel.text = "TIME IS OVER!\nRemove pot from heat"
      isStart = !isStart
      playAlarm()
    }
    
    
  }
  
  
  func playAlarm() {
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
  
  func stopAlarm() {
    player?.stop()
  }
  
}

