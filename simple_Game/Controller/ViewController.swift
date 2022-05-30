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
    
    private var isGameStarted = false
    private var gameTimeLeft: TimeInterval = 0
    
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
        gameTimeLeft = timeStepper.value
        isGameStarted = true
        updateView()
    }
    
    private func stopGame() {
        isGameStarted = false
        updateView()
    }
    
    private func updateView() {
        timeStepper.isEnabled = !isGameStarted
        
        if isGameStarted {
            timeLabel.text = "Remaining: \(Int(timeStepper.value)) sec"
            gameButton.setTitle("Stop", for: .normal)
        } else {
            timeLabel.text = "Time: \(Int(timeStepper.value)) sec"
            gameButton.setTitle("Start", for: .normal)
        }
    }
}

