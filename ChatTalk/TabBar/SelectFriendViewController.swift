//
//  SelectFriendViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/04.
//


import UIKit
import Firebase

class SelectFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "개인정보 수정"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectFriendCell = tableView.dequeueReusableCell(withIdentifier: "SelectFriendTableViewCell", for: indexPath) as! SelectFriendTableViewCell
        
        return selectFriendCell
    }
}
