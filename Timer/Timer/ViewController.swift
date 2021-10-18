

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  
  //properties:
  let denteTime = 4
  let normalTime = 6
  var secondsLeft = 0
  var timer: Timer!
  var player: AVAudioPlayer?
  
  
  //methods:
  override func viewDidLoad() {
    super.viewDidLoad()
    questionLabel.numberOfLines = 0
    questionLabel.text =
      "How do you want to boil pasta?\n Al dente or Normal"
    progressView.progress = 0.0
  }
  
  
  //this method connected both timer buttons:
  @IBAction func boilingTypePressed (_ sender: UIButton,
                                     time: Int){
    print("\n\nSender: \(sender.currentTitle!)")
    
    let boilingType = sender.currentTitle!
    
    stopAlarm()
    
    if boilingType == "Dente" {
      print("Dente Time: \(denteTime)")
      secondsLeft = denteTime
      questionLabel.text = "Boiling pasta Al dente Timer"
      progressView.progress = 0.0
      
    } else {
      print("Normal Time: \(normalTime)")
      secondsLeft = normalTime
      questionLabel.text = "Boiling pasta Normal Timer"
      progressView.progress = 0.0
    }
    
    //schedule the timer:
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  
  //creates a timer:
  @objc func updateTimer() {
    
    if secondsLeft > 0 {
      progressView.setProgress(Float(secondsLeft), animated: true)
      print("secondsLeft: \(secondsLeft)")
      secondsLeft -= 1
      
    } else {
      timer.invalidate()
      questionLabel.text = "TIME IS OVER!\n Remove pot from heat"
      playAlarm()
    }
  }
  
  
  //method that will play the alarm sound:
  func playAlarm() {
    guard let url = Bundle.main.url(forResource: "alarm",
                                    withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback,
                                                      mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url,
                                 fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  //method to stop alarm sound:
  func stopAlarm() {
    player?.stop()
  }
}
