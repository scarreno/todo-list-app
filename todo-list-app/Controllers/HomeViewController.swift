//
//  ViewController.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 25-10-21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

extension Encodable {
    var toDictionnary: [String : Any]? {
        guard let data =  try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

struct Task : Encodable {
    let id: String
    let task: String
    let isDone: String
    let registerDate: String
    
    private enum CodingKeys: String, CodingKey {
           case task, isDone, registerDate
       }
    
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var database = Database.database().reference()
    let currentUser = Auth.auth().currentUser;
    
    var todoListItems: [Task] = []
    
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
        setupData()
        setupTableView()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(rightButtonTapped))
    }
    
    func setupData(){
        if let uid = self.currentUser?.uid {
            database.child("users").child(uid).getData { error, snapshot in
                guard error == nil else {
                   print(error!.localizedDescription)
                   return;
                 }

                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    for taskItem in dictionary {
                        let task = Task(id: taskItem.key, task: taskItem.value["task"] as! String, isDone: (taskItem.value["isDone"] as! String), registerDate: taskItem.value["registerDate"] as! String)
                        self.todoListItems.append(task)
                    }
                    self.tableView.reloadData()
                    print(dictionary)
                }
            }
        }
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
        let taskItem = todoListItems[indexPath.row] as Task
        cell.titleLabel.text = taskItem.task
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
            
            if let uid = self.currentUser?.uid {
                let taskId = "task\(Int.random(in: 0..<10000))"
                let newTask = Task(id: taskId, task: newItem, isDone: "false", registerDate: Date().formatted())
                print(newTask)
                
               
                self.database.child("users").child(uid).child(taskId).setValue(newTask.toDictionnary)
                
                self.todoListItems.append(newTask)
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       }
}

