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
  @IBOutlet weak var percentageLabel: UILabel!
  @IBOutlet weak var denteImageView: UIImageView!  
  
  
  
  var timer: Timer!
  var timeRemaining: Float!
  var isStart = false
  var player: AVAudioPlayer?
  let denteTime = 4.0
  let normalTime = 6.0
  var secondsLeft = 0.0
  var secondsPassed = 0.0
  var totalTime = 0.0
  var startNow: String!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    let name = UserDefaults.standard.string(forKey: "alarmName") ?? "Unknown"
    
    if name == "Unknown" {
      UserDefaults.standard.set("alarm", forKey: "alarmName")
    }


    print(name)
    
  }
  
 
  @IBAction func selectorAlarm(_ sender: UIButton) {
    
    let selectorAlarmName = sender.currentTitle!
    print(selectorAlarmName)
    UserDefaults.standard.set(selectorAlarmName, forKey: "alarmName")
    playAlarm()
  }
  
  @IBAction func StopSound(_ sender: UIButton) {
    stopAlarm()
  }
  
  
  @IBAction func boilingTypeSelected(_ sender: UIButton) {
    let boilingType = sender.currentTitle
    stopAlarm()
    if boilingType == "Normal" {
      questionLabel.text = "Boiling pasta al normal."
      normalStart()
    }else{
      questionLabel.text = "Boiling pasta al dente."
      denteStart()
    }
  }
  
  
  
  
  func denteStart() {
    if isStart {
      timer.invalidate()
      isStart = !isStart
    }else{
      if secondsLeft == 0 || startNow == "Normal" {
        // animation for image view
        UIView.animate(withDuration:2.0, animations: {
          self.normalImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        })
        startNow = "Dente"
        secondsLeft = denteTime
        totalTime = denteTime
        secondsPassed = 0
        progressView.progress = 0.0
        percentageLabel.text = "0%"
      }
      isStart = true
      self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector:
                                            #selector(ViewController.updateTimer),
                                        userInfo: denteImageView,
                                        repeats: true)
    }
  }
  
  
  func normalStart() {
    if(isStart){
      timer.invalidate()
      isStart = !isStart
    }else{
      if secondsLeft == 0 || startNow == "Dente" {
        // animation for image view
        UIView.animate(withDuration:2.0, animations: {
          self.denteImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        })
        startNow = "Normal"
        secondsLeft = normalTime
        totalTime = normalTime
        secondsPassed = 0
        progressView.progress = 0.0
        percentageLabel.text = "0%"
      }
      isStart = true
      self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector:
                                            #selector(ViewController.updateTimer),
                                        userInfo: normalImageView,
                                        repeats: true)
    }
  }
  
  
  @objc func updateTimer() {
    let image = timer.userInfo as! UIView
    print(Float(secondsLeft))
    secondsLeft -= 1
    secondsPassed += 1
    
    let percentageProgress = secondsPassed / totalTime
    percentageLabel.text = "\(Int(percentageProgress * 100))%"
    progressView.progress = Float(percentageProgress)
    
    if secondsLeft > 0 {
      // animation for image view
      UIView.animate(withDuration:2.0, animations: { [self] in
        image.transform = CGAffineTransform(rotationAngle: CGFloat(90 + secondsPassed))
      })
      
    }else {
      // animation for image view
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
    let name = UserDefaults.standard.string(forKey: "alarmName") ?? "Unknown alarm"
    guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
    
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

