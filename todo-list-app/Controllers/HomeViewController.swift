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
    let title: String
    let description: String
    var isDone: Bool
    let registeredDate: Int64
    let modificationDate: Int64?
    
    private enum CodingKeys: String, CodingKey {
           case title, description, isDone, registeredDate, modificationDate
       }
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var delegate: HomeControllerDelegate?
    var rightAnchorConstraint: NSLayoutConstraint?
    
    var isSlideMenuPresented = false
    var database = Database.database().reference()
    let currentUser = Auth.auth().currentUser;
    
    var todoListItems: [Task] = []
    
    let tableView: UITableView = {
    let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .white
        return tv
    }()
    
    lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleMenuToggle))
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    @objc func handleMenuToggle(){
        print("left ")
        delegate?.handleMenuToggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = .systemBackground
        setupData()
        setupTableView()
        
        navigationItem.title = "Pendientes"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setLeftBarButton(menuBarButtonItem, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-add-100"), style: .plain, target: self, action: #selector(rightButtonTapped))
        
        let constant = view.frame.width * -1
        menuView.pinMenuTo(view: view)
        
        rightAnchorConstraint = NSLayoutConstraint(item: menuView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: constant)
        
        view.addConstraint(rightAnchorConstraint!)
        
    }
    
    func setupData(){
        if let uid = self.currentUser?.uid {
            database.child("users").child(uid).getData { error, snapshot in
                guard error == nil else {
                   print(error!.localizedDescription)
                   return;
                 }

                if let dictionary = snapshot.value as? [String: AnyObject] {
                    for taskItem in  dictionary {
                        let task = Task(id: taskItem.key, title: taskItem.value["title"] as! String, description: taskItem.value["description"] as! String, isDone: taskItem.value["isDone"] as! Bool, registeredDate: taskItem.value["registeredDate"] as! Int64, modificationDate:  taskItem.value["modificationDate"] as? Int64)
                        
                        self.todoListItems.append(task)
                    }
                    self.todoListItems = self.todoListItems.filter({ item in
                        item.isDone == false
                    }).sorted(by: { $0.registeredDate > $1.registeredDate })
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func setupTableView(){
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.edgeTo(view: view)
        //view.addSubview(tableView)
        
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
        cell.titleLabel.text = taskItem.title
        
        let regDate = Date(timeIntervalSince1970: TimeInterval(taskItem.registeredDate))
        cell.dateLabel.text = regDate.formatted()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            
            if let uid = self.currentUser?.uid, var task = self.todoListItems[indexPath.row] as? Task {
                task.isDone = true
                database.child("users").child(uid).child(task.id).updateChildValues(task.toDictionnary!)
                todoListItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }else if editingStyle == .insert{
            
        }
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func menuBarButtonTapped(_ sender: UIButton?){
        
        present(MenuViewController(), animated: true, completion: nil)
        /*
        print("tapped left")
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            
            var slideMenuInPadding: CGFloat = !self.isSlideMenuPresented ? self.view.frame.width * 0.30 * -1 : self.view.frame.width * -1
                         
            print(slideMenuInPadding)
            self.rightAnchorConstraint?.constant = slideMenuInPadding
            
        } completion: { (finished) in
            print("Animation finished: \(finished)")
            self.isSlideMenuPresented.toggle()
        }
         */

    }
    
    @objc func rightButtonTapped(_ sender: UIButton?) {
        print("tapped right")
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
            if(newItem == ""){
                return
            }
            if let uid = self.currentUser?.uid {
                let taskId = "task\(Int.random(in: 0..<10000))"
                let newTask = Task(id: taskId, title: newItem, description: "", isDone: false, registeredDate: Int64(Date().timeIntervalSince1970), modificationDate: nil)
                
                self.database.child("users").child(uid).child(taskId).setValue(newTask.toDictionnary)
                self.todoListItems.append(newTask)
                
                self.todoListItems = self.todoListItems.sorted(by: { $0.registeredDate > $1.registeredDate })
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       }
}

public extension UIView {
    func edgeTo(view: UIView)  {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(view: UIView){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
