//
//  FavoriteCell.swift
//  Skid
//
//  Created by Tyler Torres on 5/6/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate {
    func didTapDelete(id: Int)
}

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var employee: Employee!
    var delegate: FavoriteCellDelegate?
    
    func setUpCell(for cellInfo: Employee) {
        self.employee = cellInfo
        
        name.text = cellInfo.name
        profilePic.image = UIImage(named: cellInfo.name)
        profilePic.clipsToBounds = true
        
        viewCell.layer.cornerRadius = viewCell.frame.height / 2
        viewCell.backgroundColor = UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 0.50)
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        
        deleteButton.tintColor = .white
        deleteButton.backgroundColor = UIColor(red: 0.75, green: 0.13, blue: 0.13, alpha: 1.00)
        deleteButton.layer.cornerRadius = 15
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        delegate?.didTapDelete(id: employee.id)
    }
}
