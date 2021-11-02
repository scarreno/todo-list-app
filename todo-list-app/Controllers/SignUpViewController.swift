//
//  SignUpController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 01-11-21.
//

import UIKit
import FirebaseAuth

class SignUpViewController : UIViewController {
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Crear Usuario"
        lb.backgroundColor = .systemBackground
        lb.sizeToFit()
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        return lb
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 6
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let passTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 6
        tf.backgroundColor = .white
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passConfirmationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Reescribe Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 6
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signUpButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Crear", for: .normal)
        btn.backgroundColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passTextField)
        view.addSubview(passConfirmationTextField)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            emailTextField.widthAnchor.constraint(equalToConstant: 40),
            
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            passTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            passTextField.widthAnchor.constraint(equalToConstant: 40),
            
            passConfirmationTextField.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 10),
            passConfirmationTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            passConfirmationTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            passConfirmationTextField.widthAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passConfirmationTextField.bottomAnchor, constant: 20),
            signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            signUpButton.widthAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    @objc func signUpPressed(sender: UIButton){
        
        if let email = emailTextField.text, let password = passTextField.text, let passConfirmation = passConfirmationTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
            }
        }
    }
}
