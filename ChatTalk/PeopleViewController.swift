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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PeopleInfoTableViewCell")
        
        self.peopleInfoArr.removeAll()

        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let userModel = UserModel()
                userModel.setValuesForKeys(snapChild.value as! [String:Any])
                
                self.peopleInfoArr.append(userModel)
                print("peopleInfoArrAppend :: \(self.peopleInfoArr.count)")
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("peopleInfoArr :: \(peopleInfoArr.count)")
        return peopleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let peopleInfoCell = tableView.dequeueReusableCell(withIdentifier: "PeopleInfoTableViewCell", for: indexPath) as! PeopleInfoTableViewCell
        print("indexPath :: \(indexPath)")
//        URLSession.shared.dataTask(with: URL(string: peopleInfoArr[indexPath.row].profileImage!)!) { (data, response, error) in
//
//            print("setData :: \(data)")
//
//        }.resume()
        
        peopleInfoCell.setData(peopleInfoArr[indexPath.row])
        
        return peopleInfoCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
 
