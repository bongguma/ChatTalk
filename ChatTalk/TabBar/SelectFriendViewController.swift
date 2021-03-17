//
//  SelectFriendViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/04.
//


import UIKit
import Firebase
import BEMCheckBox


// 받는 쪽에서 protocol를 상속 받아 메소드를 활용할 수 있도록 한다.
class SelectFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BEMCheckBoxDelegate, SelectFriendProtocol {
    
    var users = Dictionary<String, Bool>()
    
    var peopleInfoArr:[UserModel] = []
    
    var myUid : String?
    
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
        
        users[myUid!] = true
        
        let nsDic = users as! NSDictionary
        
        Database.database().reference().child("chatrooms").childByAutoId().child("users").setValue(nsDic)
    }
    
    // 데이터 전달 받기
    func selectFriendCheckUsers(users: [String : Bool]) {
        self.users = users
    }
    
}
