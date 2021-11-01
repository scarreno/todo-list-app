//
//  WelcomeViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 31-10-21.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Bienvenido!"
        lb.backgroundColor = .systemBackground
        lb.sizeToFit()
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        return lb
    }()
    
    let signInButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign In", for: .normal)
        btn.backgroundColor = .lightGray
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return btn
    }()
    
    let signUpButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = .lightGray
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            signInButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func signInPressed(sender :UIButton){
        navigationController?.pushViewController(SignInController(), animated: true)
    }
    
    @objc func signUpPressed(sender :UIButton){
        navigationController?.pushViewController(SignInController(), animated: true)
    }
    
}
