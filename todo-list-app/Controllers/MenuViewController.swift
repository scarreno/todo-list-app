//
//  MenuViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 16-11-21.
//

import UIKit

class MenuViewController : UIViewController {

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    let menuView: UIView = {
        let mView = UIView()
        mView.backgroundColor = .red
        mView.translatesAutoresizingMaskIntoConstraints = false
        return mView
    }()
        
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu";
        self.view.backgroundColor = .systemGray
        
        stackView.addArrangedSubview(menuView)
        stackView.addArrangedSubview(emptyView)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
}
