//
//  GameControlViewClass.swift
//  simple_Game
//
//  Created by Давид Тоноян  on 31.05.2022.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    @IBOutlet weak var actionButton: CustomButton!
    
    @IBInspectable var gameTimeLeft: Double = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var isGameStarted: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            timeStepper.value
        }
        set {
            timeStepper.value = newValue
            updateView()
        }
    }
    var startStopHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    private func setupView() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, . flexibleHeight]
        self.addSubview(xibView)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateView()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        startStopHandler?()
    }
    
    private func updateView() {
        timeStepper.isEnabled = !isGameStarted
        
        if isGameStarted {
            timeLabel.text = "Remaining: \(Int(gameTimeLeft)) sec"
            actionButton.setTitle("Stop", for: .normal)
        } else {
            timeLabel.text = "Time: \(Int(timeStepper.value)) sec"
            actionButton.setTitle("Start", for: .normal)
        }
    }
}
