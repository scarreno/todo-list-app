//
//  ViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 25-10-21.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var todoListItems: [String] = []
    
    let tableView: UITableView = {
    let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .white
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Todo List"
        view.backgroundColor = .systemBackground
        
        setupTableView()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(rightButtonTapped))
    }
    
    func setupTableView(){
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ItemCell
        cell.backgroundColor = .systemBackground
        let item = todoListItems[indexPath.row]
        cell.titleLabel.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            todoListItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{
            
        }
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc func rightButtonTapped(_ sender: UIButton?) {
           var textField = UITextField()
        
        let alert = UIAlertController(title: "Ingresa una tarea", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Ingresa"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Agregar item", style: .default) { action in
            guard let newItem = textField.text else {
                    return
                }
            self.todoListItems.append(newItem)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       }
}

