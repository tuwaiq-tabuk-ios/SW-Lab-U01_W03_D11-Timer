//
//  ViewController.swift
//  Timer2
//
//  Created by Ressam Al-Thebailah on 11/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  let denteTime:Int = 4 //360
  let normalTime:Int = 6 //660
  
  var player: AVAudioPlayer?
  var secondsPassed = 0
  var timer = Timer()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    //    questionLabel.numberOfLines = 0
    progressView.progress = 0.0
  }
  
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    //print("\nsender: \(sender.currentTitle!)")
    timer.invalidate()
    let boilingType = sender.currentTitle!
    stopSound()
    questionLabel.text = "How do you want to boil pasta?\nAl dente o normal "
    if boilingType == "Dente" {
      secondsPassed = denteTime
      progressView.progress = 0.0
      questionLabel.text = "Boiling pasta al dente"
      
    }else{
      secondsPassed = normalTime
      progressView.progress = 0.0
      questionLabel.text = "Boiling pasta normal"
      
    }
    timer = Timer.scheduledTimer(timeInterval: 1.0 ,
                                 target: self ,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
    
  }
  
  
  @objc func updateTimer() {
    if secondsPassed > 0 {
      progressView.setProgress(Float(secondsPassed), animated: true)
      print("seconsLeft : \(secondsPassed)")
      secondsPassed -= 1
    }else{
      timer.invalidate()
      questionLabel.text = "Time Over!\nRemove pot from heat"
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
      
      guard let player = player else {
        return
      }
      
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
    func stopSound(){
      player?.stop()
    }
  }



