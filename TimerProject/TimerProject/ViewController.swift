
import UIKit
import AVFoundation

class ViewController: UIViewController {
  

  @IBOutlet weak var quastionLabel: UILabel!
  
  
  
  @IBOutlet weak var progressView: UIProgressView!
  
  
  let denteTime = 4
  let normalTime = 6
  var secondsLeft = 0
  var timer: Timer!
  var player: AVAudioPlayer?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progressView.progress = 0.0
    
  }

  @IBAction func bollingTypePressed(_ sender: UIButton) {
    
    
    let bollingType = sender.currentTitle!
    stopSound()
    print(bollingType)
    
    
    if bollingType == "Normal" {
      secondsLeft = normalTime
      progressView.progress = 0.0
      quastionLabel.text = "boiling pasta normal time"
      
    }else{
      secondsLeft = denteTime
      progressView.progress = 0.0
      quastionLabel.text = "boiling pasta dente time"
      
    }
    
    
    
timer = Timer.scheduledTimer(timeInterval: 1.0,
target: self,
selector: #selector(updateCounter),
userInfo: nil,
repeats: true)

  }
  
  
  @objc func updateCounter() {
      //example functionality
      if secondsLeft > 0 {
        progressView.setProgress(Float(secondsLeft), animated: true)
          print("\(secondsLeft) seconds to the end of the world")
        secondsLeft -= 1
      }else{
        timer.invalidate()
        quastionLabel.text = "TIME OVER! \nRemove pot from heat"
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

