//
//  HomeButton.swift
//  Skid
//
//  Created by Tyler Torres on 6/14/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class HomeButton: UIButton {
    
    required init(title: String) {
        super.init(frame: .zero)
        setupButton(text: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButton(text: String) {
        setTitle(text, for: .normal)
        setTitleColor(.white, for: .normal)
    
        titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 18)
        backgroundColor = .generateColor()
        layer.cornerRadius = 10
        contentEdgeInsets = UIEdgeInsets(top: 7, left: 9, bottom: 7, right: 9)
    }
}
