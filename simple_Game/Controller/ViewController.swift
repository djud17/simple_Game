//
//  ViewController.swift
//  simple_Game
//
//  Created by Давид Тоноян  on 30.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var timeStepper: UIStepper!
    @IBOutlet weak var gameButton: CustomButton!
    @IBOutlet weak var gameObject: CustomGameObject!
    @IBOutlet weak var gameObjectXConstraint: NSLayoutConstraint!
    @IBOutlet weak var gameObjectYConstraint: NSLayoutConstraint!
    
    private var isGameStarted = false
    
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    
    private var gameObjectTimer: Timer?
    private let gameObjectDisplayDuration: TimeInterval = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.red.cgColor
        gameFieldView.layer.cornerRadius = 10
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateView()
    }
    
    @IBAction func actionBtnTapped(_ sender: UIButton) {
        if isGameStarted {
            stopGame()
        } else {
            startGame()
        }
    }
    
    private func startGame() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(gameTimerTick),
                                         userInfo: nil,
                                         repeats: true)
        gameTimeLeft = timeStepper.value
        
        gameObjectTimer?.invalidate()
        gameObjectTimer = Timer.scheduledTimer(timeInterval: gameObjectDisplayDuration,
                                               target: self,
                                               selector: #selector(moveGameObject),
                                               userInfo: nil,
                                               repeats: true)
        gameObjectTimer?.fire()
        
        isGameStarted = true
        updateView()
    }
    
    private func stopGame() {
        isGameStarted = false
        updateView()
        gameTimer?.invalidate()
        gameObjectTimer?.invalidate()
    }
    
    private func updateView() {
        timeStepper.isEnabled = !isGameStarted
        
        if isGameStarted {
            timeLabel.text = "Remaining: \(Int(gameTimeLeft)) sec"
            gameButton.setTitle("Stop", for: .normal)
        } else {
            timeLabel.text = "Time: \(Int(timeStepper.value)) sec"
            gameButton.setTitle("Start", for: .normal)
            gameObjectXConstraint.constant = 0
            gameObjectYConstraint.constant = 0
        }
    }
    
    @objc private func gameTimerTick() {
        gameTimeLeft -= 1
        if gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateView()
        }
    }
    
    @objc private func moveGameObject() {
        let maxX = gameFieldView.bounds.maxX - gameObject.frame.width
        let maxY = gameFieldView.bounds.maxY - gameObject.frame.height
        gameObjectXConstraint.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        gameObjectYConstraint.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
}

