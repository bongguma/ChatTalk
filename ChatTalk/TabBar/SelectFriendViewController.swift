//
//  SelectFriendViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/04.
//


import UIKit
import Firebase
import BEMCheckBox

class SelectFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BEMCheckBoxDelegate {
    
    var users = Dictionary<String, Bool>()
    
    var peopleInfoArr:[UserModel] = []
    
    var myUid : String?
    
    var delegate : SelectFriendProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var makeChatRoomBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "개인정보 수정"
        
        
        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in

            // 현재 로그인 된 유저 uid 저장
            self.myUid = Auth.auth().currentUser?.uid
            
            self.peopleInfoArr.removeAll()
            
            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let userModel = UserModel()
                userModel.setValuesForKeys(snapChild.value as! [String:Any])
                if !(self.myUid?.elementsEqual(userModel.uid!))!{
                    self.peopleInfoArr.append(userModel)
                }
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectFriendCell = tableView.dequeueReusableCell(withIdentifier: "SelectFriendTableViewCell", for: indexPath) as! SelectFriendTableViewCell
        
        selectFriendCell.setUiUpdate(peopleInfoArr[indexPath.row], indexPath.row, users)
        
        return selectFriendCell
    }
    
    @IBAction func makeChatRoomAction(_ sender: Any) {
        var myUid = Auth.auth().currentUser?.uid
        
        print("(delegate?.selectFriendCheckUsers())! :: \(delegate!.selectFriendCheckUsers()) ")
        users = (delegate!.selectFriendCheckUsers())
        users[myUid!] = true
        
        let nsDic = users as! NSDictionary
        
        Database.database().reference().child("chatrooms").childByAutoId().child("users").setValue(nsDic)
    }
}