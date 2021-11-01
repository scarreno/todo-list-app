//
//  SignInController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 31-10-21.
//

import UIKit

class SignInController : UIViewController {
    
    
    let userTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Usuario"
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 6
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 6
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signInButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .lightGray
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        title = "Sign In"
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(userTextField)
        self.view.addSubview(passTextField)
        self.view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            userTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            userTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            userTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            userTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            passTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            passTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            passTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 40),
            signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    @objc func signInPressed(){
        
    }
}
