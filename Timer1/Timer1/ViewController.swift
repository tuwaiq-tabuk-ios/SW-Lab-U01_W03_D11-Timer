//
//  ViewController.swift
//  Timer1
//
//  Created by Atheer abdullah on 12/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
  var counter = 30
  let denteTime = 4.0
  let normalTime  = 6.0
  var totalTime = 0.0
  var secondsPassed = 0.0
  var timer: Timer!
  var player: AVAudioPlayer?
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progressView.progress = 0.0
  }
  
  @IBAction func boilingTypePressed(_ sender: UIButton) {
    print("sender: \(String(describing: sender.currentTitle))")
    let boilingType = sender.currentTitle!
    stopSound()
    if boilingType == "Normal" {
      secondsPassed = normalTime
      progressView.progress = 0.0
      print("normalTime:\(normalTime)")
      questionLabel.text = "Boiling pasta normal time"
    }else{
      secondsPassed = denteTime
      progressView.progress = 0.0
      print("denteTime:\(denteTime)")
      questionLabel.text = "Boiling pasta denta time"
    }
  
  
   timer = Timer.scheduledTimer(timeInterval: 1.0,
                                target: self, selector: #selector(updateCounter),
                                userInfo: nil,
                                repeats: true)
  }

  @objc func updateCounter() {
    progressView.setProgress(Float(secondsPassed), animated: true)
      //example functionality
      if secondsPassed > 0 {
          print("\(secondsPassed) seconds to the end of the world")
          secondsPassed -= 1  }else{
        timer.invalidate()
        questionLabel.text = "TIME IS OVER!\nRemove pot from heat"
        playSound()
            
            
          let percentageProgress = (secondsPassed) / (totalTime)
         print("percentageProgress: \(percentageProgress)")
            progressView.progress = Float(percentageProgress)

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
