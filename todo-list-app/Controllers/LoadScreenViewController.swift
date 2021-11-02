//
//  LoadScreenViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 01-11-21.
//

import UIKit

class LoadScreenViewController : UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    let messageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Cargando..."
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .clear
        lb.textColor = .black
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        return lb
    }()
    
 override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        view.addSubview(messageLabel)
        view.inputViewController?.modalPresentationStyle = .fullScreen
     
        view.backgroundColor = UIColor(red: 0.96, green: 0.16, blue: 0.05, alpha: 0.8)
                
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            messageLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 40)
        ])        
    }
    
}
