//
//  ViewController.swift
//  Project5
//
//  Created by Ahmad Hasan on 10/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    let questions = [["China is the largest country in the world", "No"], ["5 + 8 x 9 = 77", "Yes"], ["Spider have 6 legs", "No"], ["The capital of Spain is Madrid", "Yes"], ["14 x 11 = 144", "No"]]
    
    var questionNumber = 0
    var count = 0
    var totalScore = 0
    var timer1 = Timer()
    var timer2 = Timer()
    var time = 6
    var seconds = 0
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBOutlet weak var questionsLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var beginButton: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsLabel.text = "                             Rules \n1. If answer is correct, score will be increased by $100\n2. If wrong will be decreased by $50\n3. 5 seconds to answer each question \n4. If answer is delayed the answer will be treated as wrong\n"
        yesButton.isEnabled = false
        noButton.isEnabled = false
        playAgainButton.isHidden = true
        timerLabel.isHidden = true
    }
    
    func Start(){
        beginButton.isHidden = true
        yesButton.isEnabled = true
        noButton.isEnabled = true
        playAgainButton.isHidden = true
        timerLabel.isHidden = false
        
        timer1.invalidate()
        timer2.invalidate()
        seconds = 0
        questionNumber = 0
        totalScore = 0
        count = 0
        progressBar.progress = 0
        ScoreLabel.text = "$0"
        questionsLabel.text = questions[questionNumber][0]
        timer1 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer2), userInfo: nil, repeats: true)
    }
    
    func finish()
    {
        switch count{
        case 5:
            questionsLabel.text = "Congratulations! You got a perfect Score!\n Score: \(totalScore)"
        case 4:
            questionsLabel.text = "Well done! You got 4 out of 5 questions correctly\n Score: \(totalScore)"
        case 3:
            questionsLabel.text = "3 out of 5 Good Job\n Score: \(totalScore)"
        case 2:
            questionsLabel.text = "2 out of 5 Good Luck next time\n Score: \(totalScore)"
        case 1:
            questionsLabel.text = "1 out of 5 Study More\n Score: \(totalScore)"
        case 0:
            questionsLabel.text = "0 out 5 (STUDY STUDY STUDY)\n Score: \(totalScore)"
        default:
            print("Error")
        }
        playAgainButton.isHidden = false
        yesButton.isEnabled = false
        noButton.isEnabled = false
        timerLabel.isHidden = true
    }
    
    @IBAction func beginButtonPressed(_ sender: UIButton) {
        Start()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
       Start()
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        timer1.invalidate()
        timer2.invalidate()
        seconds = 0
        
        if sender.currentTitle == questions[questionNumber][1] {
            
            sender.backgroundColor = UIColor.green
            totalScore += 100
            count += 1
            progressBar.progress = Float(count) / Float(5)
        } else {
            sender.backgroundColor = UIColor.red
            totalScore -= 50
        }
        
        timer1 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer2), userInfo: nil, repeats: true)
        
        questionNumber = (questionNumber + 1) % 5
        questionsLabel.text = questions[questionNumber][0]
        
        
        if (questionNumber == 0) {
            finish()
            timer2.invalidate()
            timerLabel.text = "0"
        }
    }
    
    @objc func updateTimer()
    {
        ScoreLabel.text = "Score: $\(totalScore)"
        yesButton.backgroundColor = UIColor.clear
        noButton.backgroundColor = UIColor.clear
    }
    
    @objc func updateTimer2(){
        if seconds < time {
            timerLabel.text = "\(seconds)"
            seconds += 1
        } else if seconds == 6 {
            if (questionNumber == 4) {
                totalScore -= 50
                finish()
                timer2.invalidate()
                timerLabel.text = "0"
            } else {
                totalScore -= 50
                questionNumber = (questionNumber + 1) % 5
                questionsLabel.text = questions[questionNumber][0]
                seconds = 0
            }
        } else {
            totalScore -= 50
            questionNumber = (questionNumber + 1) % 5
            questionsLabel.text = questions[questionNumber][0]
            seconds = 0
        }
    }
}


