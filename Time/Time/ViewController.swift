
import UIKit
import AVFoundation
class ViewController: UIViewController {
  var player = AVAudioPlayer()
  @IBOutlet weak var UIProgress: UIProgressView!
  
  @IBOutlet weak var topLabel: UILabel!
  let denteTime: Int =  4
  let normalTime: Int = 6
  var totalTime = 0
  var secondsPassed = 0
  var secondsLeft = 0
  var timer:Timer = Timer()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func Normal_bottn(_ sender: UIButton) {
    timer.invalidate()
    let boilingType = sender.currentTitle!
    
    if boilingType == "Dente" {
      print("denteTime: \(denteTime)")
      topLabel.text = "Boiling pasta al dente"
      secondsLeft = denteTime
      totalTime = denteTime
    } else {
      print("normalTime: \(normalTime)")
      topLabel.text = "Boiling pasta normal"
      secondsLeft = normalTime
      totalTime=normalTime
    }
    
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
    
  }
  @objc func updateTimer() {
    //example functionality
    if secondsLeft > 0 {
      print("secondsLeft: \(secondsLeft)")
      secondsLeft -= 1
      secondsPassed += 1
    } else {
      playSound()
      timer.invalidate()
      topLabel.text = "TIME FINSHED \nRemove pot from heat"
      secondsPassed = 0
      // UIProgress.progress = 1.0
    }
    let percentageProgress = Double (secondsPassed)/Double(totalTime)
    print(percentageProgress)
    UIProgress.progress = Float(percentageProgress)
  }
  func playSound() {
    let path = Bundle.main.path(forResource: "alarm", ofType : "wav")!
    let url = URL(fileURLWithPath : path)
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player.play()
    } catch {
      print ("There is an issue with this code!")
    }
  }
}





