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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.red.cgColor
        gameFieldView.layer.cornerRadius = 10
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        timeLabel.text = "Time: \(sender.value) sec"
    }
}

