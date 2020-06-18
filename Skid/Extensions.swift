//
//  Extensions.swift
//  Skid
//
//  Created by Tyler Torres on 5/4/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UILabel {
    func addLineSpacing(spaceValue: CGFloat = 1.5) {
        guard let textString = text else { return }
        
        let attrString = NSMutableAttributedString(string: textString)
        
        let spaceStyling = NSMutableParagraphStyle()
        spaceStyling.lineSpacing = spaceValue
        spaceStyling.alignment = .center
        
        attrString.addAttribute(.paragraphStyle, value: spaceStyling, range: NSRange(location: 0, length: attrString.length))
        
        attributedText = attrString
    }
}

extension UIDevice {
    static func playSoundOnFavorite() {
        AudioServicesPlayAlertSound(SystemSoundID(1022))
    }
}

extension String {
    func checkAndSplit() -> String {
        if self.contains("_") {
            let splitArray = self.split(separator: "_")
            return splitArray[0].capitalized + " " + splitArray[1].capitalized
        } else {
            return self.capitalized
        }
    }
}

extension UIButton {
    func setSkillsButton() {
        self.backgroundColor = UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 1.00)
        self.tintColor = .white
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = false
        self.contentEdgeInsets = UIEdgeInsets(top: 7, left: 9, bottom: 7, right: 9)
    }
}

var activityView: UIView?
extension UITableViewController {
    func showSpinner() {
        activityView = UIView(frame: self.view.bounds)
        activityView!.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func removeSpinner() {
        activityView?.removeFromSuperview()
        // Cleanup of memory
        activityView = nil
    }
}


extension UIColor {
    static func generateColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
    static func themeColor() -> UIColor {
        return UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 0.50)
    }
}

extension UIButton {
    func setSkillsBtn(name: String) {
        self.backgroundColor = .generateColor()
        self.setTitle(name, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20)
    }
    
}
