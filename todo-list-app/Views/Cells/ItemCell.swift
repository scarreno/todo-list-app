//
//  ItemCell.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 26-10-21.
//

import Foundation
import UIKit


class  ItemCell: UITableViewCell{
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.sizeToFit()
        return label
        
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(cellView)
        
        cellView.addSubview(titleLabel)
        cellView.addSubview(dateLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20).isActive = true
        
        dateLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
