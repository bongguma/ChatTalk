//
//  ChatRoomViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/19.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var uid : String?
    var chatRooms : [ChatModel]! = []
    var destinationUsers : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "채팅방"
        self.uid = Auth.auth().currentUser?.uid
        self.getChatRoomList()
    }
    
    func getChatRoomList(){
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+self.uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value) { (dataSnapShot) in
            for item in dataSnapShot.children.allObjects as! [DataSnapshot]{
                if let chatRoomdic = item.value as? [String:Any]{
                    let chatModel = ChatModel(JSON: chatRoomdic)
                    self.chatRooms.append(chatModel!)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatRowCell = tableView.dequeueReusableCell(withIdentifier: "ChatRowCell", for: indexPath) as! ChatRowCell
        
        chatRowCell.setUiUpdate(chatRooms[indexPath.row], uid!)
        
        var destinationUid : String?
        
        for item in chatRooms[indexPath.row].users {
            if item.key != self.uid {
                destinationUid = item.key
                destinationUsers.append(destinationUid!)
            }
        }
        
        return chatRowCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let destinationUid = self.destinationUsers[indexPath.row]
        let chatViewController = self.storyboard?.instantiateViewController(identifier: "ChatViewController") as! ChatViewController
        chatViewController.destinationUid = destinationUid
        
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}
