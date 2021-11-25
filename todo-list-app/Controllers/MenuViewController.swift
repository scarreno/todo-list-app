//
//  MenuViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 16-11-21.
//

import UIKit


class MenuViewController : UIViewController {

    var delegate: HomeControllerDelegate?
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menú"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return label
    }()
        
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return view
    }()
    
    let signOutBUtton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cerrar Sesión", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 6
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.layer.borderWidth = 0.0
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
        
        return btn
    }()
    
    
    @objc func signOutPressed(){
        self.delegate?.handleSignOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu";
        self.view.backgroundColor = .systemGray
        
        stackView.addArrangedSubview(menuTitleLabel)
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(signOutBUtton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
}
