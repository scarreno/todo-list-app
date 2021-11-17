//
//  ContainerViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 16-11-21.
//

import UIKit

class ContainerViewController : UIViewController {
    
    var menuViewController: UIViewController!
    var centercontroller: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureHomeController(){
        let homeViewController = HomeViewController()
        centercontroller = UINavigationController(rootViewController: homeViewController)
        homeViewController.delegate = self
        
        view.addSubview(centercontroller.view)
        addChild(centercontroller)
        centercontroller.didMove(toParent: self)
    }
    
    func configureMenuViewController(){
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func showMenuController(shouldExpand: Bool){
        if shouldExpand {
            //show
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centercontroller.view.frame.origin.x = self.centercontroller.view.frame.width - 80
            }, completion: nil)
        }else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centercontroller.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

extension ContainerViewController : HomeControllerDelegate {
    
    func handleMenuToggle() {
        if !isExpanded {
            configureMenuViewController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
}
