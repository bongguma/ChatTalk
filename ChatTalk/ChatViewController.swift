//
//  ChatViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/03.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTxtF: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var destinationUid: String? // 나중에 내가 채팅할 대상의 Uid
    var uid: String?
    var chatRoomUid: String?
    var comments : [ChatModel.Comment] = []
    // 채팅하는 상대의 userModel를 가져와준다.
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "채팅방"
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        uid = Auth.auth().currentUser?.uid
        
        checkChatRoom()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendAction(_ sender: Any) {
        // uid : 앱을 로그인한 유저에 대한 uid
        // destinationUid : 메신저를 받는 사람에 대한 uid
        
        let createRoomInfo = ["users" : [
            uid! : true,
            destinationUid! : true
        ]]
        
        // 채팅방이 생성 되어있지 않았을 경우, 방 생성
        if nil == chatRoomUid {
            self.sendBtn.isEnabled = false
            Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo) { (error, ref) in
                if nil == error {
                    self.checkChatRoom()
                }
            }
        }
        // 이미 방이 생성되어있었으면 채팅방 유지
        else {
            let value = [
                "uid" : uid!,
                "message" : messageTxtF.text!
            ]
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value)
        }
    }

    // 파이어베이스 안에 이미 방이 생성되어 있었는지 아닌지 확인
    func checkChatRoom(){
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/\(uid!)").queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value) { (dataSnapshot) in
            for item in dataSnapshot.children.allObjects as! [DataSnapshot]{
                // 상대방이랑 대화하던 대화방이 이미 존재하는지에 대한 확인
                if let chatRoomDic = item.value as? [String:AnyObject] {
                    let chatModel = ChatModel(JSON: chatRoomDic)
                    // 이미 상대방과 대화하던 대화방이 존재 시, true 반환
                    if (chatModel!.users[self.destinationUid!]) == true {
                        self.chatRoomUid = item.key
                        self.sendBtn.isEnabled = true
                        self.getDestinationInfo()
                    }
                }
            }
        }
    }
    
    func getDestinationInfo(){
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: {(dataSnapshot) in
            self.userModel = UserModel()
            self.userModel?.setValuesForKeys(dataSnapshot.value as! [String:Any])
            self.getMessageList()
        })
    }
    
    // 전송한 메세지 리스트에 남기는 함수
    func getMessageList(){
        Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments").observe(DataEventType.value, with: { (dataSnapshot) in
            self.comments.removeAll()
            
            for item in dataSnapshot.children.allObjects as! [DataSnapshot]{
                let comment = ChatModel.Comment(JSON:  item.value as! [String : Any])
                self.comments.append(comment!)
            }
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 로그인 되어있는 유저가 입력한 대화내용을 보여주는 tableCell
        if self.comments[indexPath.row].uid == uid{
            let chatMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageTableViewCell", for: indexPath) as! ChatMessageTableViewCell
            chatMessageTableViewCell.setUiUpdate(self.comments[indexPath.row])
            return chatMessageTableViewCell
        }
        // 로그인 되어있는 유저와 대화한 상대방의 대화내용을 보여주는 tableCell
        else {
            let destinationMessageCell = tableView.dequeueReusableCell(withIdentifier: "DestinationMessageCell", for: indexPath) as! DestinationMessageCell
            destinationMessageCell.setUiUpdate(self.comments[indexPath.row], userModel!)
            return destinationMessageCell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
