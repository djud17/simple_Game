//
//  CustomView.swift
//  simple_Game
//
//  Created by Давид Тоноян  on 30.05.2022.
//

import UIKit

class CustomGameObject: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = self.bounds.height / 2
    }
}
