//
//  SignInController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 31-10-21.
//

import UIKit
import FirebaseAuth


class SignInViewController : UIViewController {
    
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Usuario"
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
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let signInButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        title = "Sign In"
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(emailTextField)
        self.view.addSubview(passTextField)
        self.view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
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
        
        if let email = emailTextField.text , let password = passTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self]AuthDataResult, error in
                print("Signed!!!!!")
                
                self?.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        }
        
    }
}
