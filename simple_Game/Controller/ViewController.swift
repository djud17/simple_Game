//
//  ViewController.swift
//  simple_Game
//
//  Created by Давид Тоноян  on 30.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameControlView: GameControlViewClass!
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var gameObject: CustomGameObject!
    @IBOutlet weak var gameObjectXConstraint: NSLayoutConstraint!
    @IBOutlet weak var gameObjectYConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var gameTimer: Timer?
    
    private var gameObjectTimer: Timer?
    private let gameObjectDisplayDuration: TimeInterval = 2
    
    private var playerScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.red.cgColor
        gameFieldView.layer.cornerRadius = 10
        
        gameObject.isHidden = !gameControlView.isGameStarted
        
        gameControlView.startStopHandler = { [weak self] in
            self?.actionButtonTapped()
        }
        gameControlView.gameDuration = 20
    }
    
    func actionButtonTapped() {
        gameControlView.isGameStarted ? stopGame() : startGame()
    }
    
    private func startGame() {
        repositionImageWithTimer()
        playerScore = 0
        scoreLabel.text = "Score: \(playerScore)"
        gameControlView.isGameStarted = true
        
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(gameTimerTick),
                                         userInfo: nil,
                                         repeats: true)
        gameControlView.gameTimeLeft = gameControlView.gameDuration
        
        gameObject.isHidden = !gameControlView.isGameStarted
    }
    
    private func stopGame() {
        gameControlView.isGameStarted = false
        gameObject.isHidden = !gameControlView.isGameStarted
        
        gameTimer?.invalidate()
        gameObjectTimer?.invalidate()
    }
    
    @objc private func gameTimerTick() {
        gameControlView.gameTimeLeft -= 1
        if gameControlView.gameTimeLeft <= 0 {
            stopGame()
        } else {
            gameObject.isHidden = !gameControlView.isGameStarted
        }
    }
    
    @objc private func moveGameObject() {
        let maxX = gameFieldView.bounds.maxX - gameObject.frame.width
        let maxY = gameFieldView.bounds.maxY - gameObject.frame.height
        gameObjectXConstraint.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        gameObjectYConstraint.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
    
    private func repositionImageWithTimer() {
        gameObjectTimer?.invalidate()
        gameObjectTimer = Timer.scheduledTimer(timeInterval: gameObjectDisplayDuration,
                                               target: self,
                                               selector: #selector(moveGameObject),
                                               userInfo: nil,
                                               repeats: true)
        gameObjectTimer?.fire()
    }
    
    @IBAction func gameObjectTapped(_ sender: UITapGestureRecognizer) {
        guard gameControlView.isGameStarted else { return }
        
        repositionImageWithTimer()
        playerScore += 1
        scoreLabel.text = "Score: \(playerScore)"
    }
}

