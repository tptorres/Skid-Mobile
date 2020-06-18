//
//  HomeVC.swift
//  Skid
//
//  Created by Tyler Torres on 6/8/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    private let azure_btn = HomeButton(title: "Azure")
    private let excel_btn = HomeButton(title: "Excel")
    private let photoshop_btn = HomeButton(title: "Photoshop")
    private let illustrator_btn = HomeButton(title: "Illustrator")
    private let indesign_btn = HomeButton(title: "Indesign")
    private let public_btn = HomeButton(title: "Public")
    private let python_btn = HomeButton(title: "Python")
    private let c_btn = HomeButton(title: "C++")
    private let frontend_btn = HomeButton(title: "Frontend")
    
    private let titleLabel = UILabel()
    
    private let viewAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("View All Employees", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .themeColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(self, action: #selector(onViewAll), for: .touchUpInside)
        return button
    }()
    
    // Animation Constraints
    var startLeftStackViewConstraint: NSLayoutConstraint!
    var startMiddleStackViewConstraint: NSLayoutConstraint!
    var startRightStackViewConstraint: NSLayoutConstraint!
    
    var skillBtnText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "PICK A SKILL"
        titleLabel.textColor = UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 0.50)
        titleLabel.font = UIFont(name: "Avenir-BlackOblique", size: 40)
        
        view.addSubview(titleLabel)
        view.addSubview(viewAllBtn)
        
        setMiscConstraints()
        setStackViews()
        setBtnActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtons()
    }
    
    func setStackViews() {
        let middleStackView = UIStackView(arrangedSubviews: [azure_btn, excel_btn, photoshop_btn])
        middleStackView.distribution = .fillEqually
        middleStackView.axis = .vertical
        middleStackView.spacing = 30
        
        let leftStackView = UIStackView(arrangedSubviews: [illustrator_btn, indesign_btn, public_btn])
        leftStackView.distribution = .fillEqually
        leftStackView.axis = .vertical
        leftStackView.spacing = 30
        
        let rightStackView = UIStackView(arrangedSubviews: [python_btn, c_btn, frontend_btn])
        rightStackView.distribution = .fillEqually
        rightStackView.axis = .vertical
        rightStackView.spacing = 30
        
        view.addSubview(middleStackView)
        view.addSubview(leftStackView)
        view.addSubview(rightStackView)
        
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        startLeftStackViewConstraint = leftStackView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -500)
        startLeftStackViewConstraint.isActive = true
        
        startMiddleStackViewConstraint = middleStackView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 500)
        startMiddleStackViewConstraint.isActive = true
        
        startRightStackViewConstraint = rightStackView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -500)
        startRightStackViewConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            leftStackView.centerXAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: -60),
            leftStackView.heightAnchor.constraint(equalToConstant: 200),
            
            middleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middleStackView.heightAnchor.constraint(equalToConstant: 200),
            
            rightStackView.centerXAnchor.constraint(equalTo: middleStackView.trailingAnchor, constant: 60),
            rightStackView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }
    
    func setMiscConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        viewAllBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewAllBtn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        viewAllBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func animateButtons() {
        startLeftStackViewConstraint.constant = 0
        startRightStackViewConstraint.constant = 0
        startMiddleStackViewConstraint.constant = 0
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 4,
                       options: .curveEaseIn, animations: {
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func onViewAll() {
        skillBtnText = nil
        performSegue(withIdentifier: "viewAll", sender: self)
    }

    
    func setBtnActions() {
        let buttons = [azure_btn,excel_btn,photoshop_btn,illustrator_btn,indesign_btn, public_btn, python_btn, c_btn, frontend_btn]
        
        for btn in buttons {
            btn.addTarget(self, action: #selector(transitionWithFilter), for: .touchUpInside)
        }
    }

    @objc private func transitionWithFilter(_ sender: UIButton) {
        guard let name = sender.currentTitle else { return }
        skillBtnText = name

        performSegue(withIdentifier: "viewAll", sender: self)
    }
    
    // Struggled with this for hours : need to go level by level if there are nested NC or TC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewAll" {
            let tabController = segue.destination as! UITabBarController
            let navController = tabController.viewControllers![0] as! UINavigationController
            let destinationVC = navController.topViewController as! EmployeeTableVC
            
            destinationVC.skill_name = skillBtnText
        }
    }
    
}



