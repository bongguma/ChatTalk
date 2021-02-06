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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            
            self.peopleInfoArr.removeAll()
            
            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let userModel = UserModel()
                userModel.setValuesForKeys(snapChild.value as! [String:Any])
                
                self.peopleInfoArr.append(userModel)
                
                print("appen :: \(self.peopleInfoArr.count)")
                
                    self.tableView.reloadData()
            }
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let peopleInfoCell = tableView.dequeueReusableCell(withIdentifier: "PeopleInfoTableViewCell", for: indexPath) as! PeopleInfoTableViewCell
        
        URLSession.shared.dataTask(with: URL(string: peopleInfoArr[indexPath.row].profileImage!)!) { (data, response, error) in
            print("data :: \(data)")
            print("response :: \(response)")
            print("error :: \(error)")
            DispatchQueue.main.async {
//                peopleInfoCell.setUiUpdate(userModel: self.peopleInfoArr[indexPath.row], data!)
            }
            
        }.resume()

        
        
        return peopleInfoCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextControllerView = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        
        nextControllerView?.destinationUid = self.peopleInfoArr[indexPath.row].uid
        
        self.navigationController?.pushViewController(nextControllerView!, animated: true)
    }
}
 
