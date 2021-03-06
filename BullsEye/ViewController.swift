//
//  ViewController.swift
//  BullsEye
//
//  Created by yzune on 2018/12/6.
//  Copyright © 2018 yzune. All rights reserved.
//

import QuartzCore
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        playBgMusic()
    }
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "Adam Young - Country Hymn", ofType: "mp3")
        let url = URL.init(fileURLWithPath: musicPath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }catch _{
            audioPlayer = nil
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound(){
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    func updateLabel(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver(){
        startNewGame()
    }

    @IBAction func showAlert(){
        let difference = abs(currentValue - targetValue)
        let points = 100 - difference
        score += points
        let message = "滑动条当前的数值为：\(currentValue)" + "\n目标数值为：\(targetValue)" + "\n两者的差值为：\(difference)"
        let alert = UIAlertController(title: "Hello", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "试试看", style: .default, handler: {_ in
            self.startNewRound()
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        // print("滑动条的当前数值为 \(slider.value)")
        currentValue = lroundf(slider.value)
    }
}

