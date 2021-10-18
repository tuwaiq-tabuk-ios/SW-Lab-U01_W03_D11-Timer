import UIKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var quesyionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var denteTime = 420
    var normalTime = 660
    var  secondsLeft = 0
    var timer:Timer!
    var player : AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        
    }


    @IBAction func boilingTypePressed(_ sender: UIButton) {
        
        let boilingType = sender.currentTitle!
        stopSound()
        if boilingType == "Normal"{
            
            print("normalTime: \(normalTime)")
            secondsLeft = normalTime
            progressView.progress = 0.0
            quesyionLabel.text = "Boiling pasta normal time "
           
        }
        else{
            
            print("denteTime: \(denteTime)")

            secondsLeft = denteTime
            progressView.progress = 0.0
            quesyionLabel.text = "Boiling pasta dente time "
        }
        
        
      timer =   Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(updateCounter),
                             userInfo: nil,
                             repeats: true)

        
    }
    
    
    @objc func updateCounter() {
        //example functionality
        
        
        if secondsLeft > 0 {
            
            progressView.setProgress(Float(secondsLeft), animated: true)
            
            print("secondsLeft: \(secondsLeft)")
            secondsLeft -= 1
            
        }
        else
        {
            
            timer.invalidate()
            quesyionLabel.text = "TIME IS OVER \n Remove pot from heat"
            playSound() 
        }
        
     //passed
        
            
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
    
   func stopSound(){
        player?.stop()
    }
    }


