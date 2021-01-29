//
//  MainViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/25.
//

import UIKit
import Firebase

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var peopleInfoArr:[UserModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let peopleInfoCell = tableView.dequeueReusableCell(withIdentifier: "peopleInfoTableViewCell", for:indexPath)
        
        URLSession.shared.dataTask(with: URL(string: peopleInfoArr[indexPath.row].profileImage!)!) { (data, response, error) in
            
            print("setData :: \(data)")
            
        }
        
        return peopleInfoCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "peopleInfoTableViewCell")
        
        self.peopleInfoArr.removeAll()
        
        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let userModel = UserModel()
                userModel.setValuesForKeys(snapChild.value as! [String:Any])
                self.peopleInfoArr.append(userModel)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
 
