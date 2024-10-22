//
//  ViewController.swift
//  Egg_Timer
//
//  Created by Aisha Suanbekova Bakytjankyzy on 22.10.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var timer: Timer?
    private var player: AVPlayer?
    
    private var eggTime: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    private var counter: Int = 0
    private var overallTime: Int = 0

    @IBOutlet weak var chooseEggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressBar.progress = 0.0
    }

   
    
    @IBAction func didTouchButton(_ sender: UIButton) {
        
        guard
            let eggTitle = sender.title(for: .normal),
            let time = eggTime[eggTitle]
        else {return}
        
        
        reset()
        overallTime = time
        chooseEggLabel.text = eggTitle
        timerProcess()
    }
    
    
    func reset(){
        counter = 0
        timer?.invalidate()
        progressBar.progress = 0.0
        chooseEggLabel.text = "Choose Egg"
    }
    

    
    func timerProcess(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.counter += 1
            self.progressBar.progress = Float(self.counter) / Float(self.overallTime)
            
            if self.counter >= self.overallTime {
                self.playAlarm()
                timer.invalidate()
                self.chooseEggLabel.text = "Done"
            }
            print(self.counter)
            print(self.overallTime)
        })
        
    }
    
    
    
    func playAlarm(){
        guard let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        else{return}
            
        player = AVPlayer(url: soundURL)
        player?.play()
    }
    
}

