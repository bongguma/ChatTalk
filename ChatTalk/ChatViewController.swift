//
//  ChatViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/03.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var chatScrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTxtF: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var uid: String?
    var chatRoomUid: String?
    
    var comments : [ChatModel.Comment] = []
    var destinationUid: String? // 나중에 내가 채팅할 대상의 Uid
    
    // 채팅하는 상대의 userModel를 가져와준다.
    var userModel: UserModel?
    
    var databaseRef : DatabaseReference?
    var observe : UInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "채팅방"
        
        chatScrollView.contentSize = CGSize(width: chatView.frame.width, height: 500)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        uid = Auth.auth().currentUser?.uid
       
        // 빈 view 공간을 누르면 키보드가 내려가는 제스처 액션
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        checkChatRoom()
        // Do any additional setup after loading the view.
    }
    
    
    // 채팅방 화면이 종료 될 때에
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
        databaseRef?.removeObserver(withHandle: observe!)
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
                "message" : messageTxtF.text!,
                "time" : ServerValue.timestamp()
            ] as [String : Any]
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value) { (error, ref) in
                
                self.messageTxtF.text = ""
            }
        }
        
        messageTxtF.resignFirstResponder()
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
        databaseRef = Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments")
        
        observe = databaseRef!.observe(DataEventType.value, with: { (dataSnapshot) in
            self.comments.removeAll()
            
            var readUserDic : Dictionary<String, AnyObject> = [:]
            
            for item in dataSnapshot.children.allObjects as! [DataSnapshot]{
                let key = item.key as! String
                let comment = ChatModel.Comment(JSON:  item.value as! [String : Any])
                comment?.readUsers[self.uid!] = true
                readUserDic[key] = comment?.toJSON() as! NSDictionary
                self.comments.append(comment!)
            }
            let nsDic = readUserDic as NSDictionary
            
            dataSnapshot.ref.updateChildValues(nsDic as! [AnyHashable : Any]) { (error, ref) in
                
            }
            
            self.tableView.reloadData()
            
            if self.comments.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(item: self.comments.count-1, section: 0), at: .bottom, animated: true)
            }
        })
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        
//      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//        let keybaordRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keybaordRectangle.height
//        print("chatView111111 :: \(chatView.frame.origin.y)")
//        print("keyboardHeight :: \(keyboardHeight)")
//        chatView.frame.origin.y -= keyboardHeight
//        print("chatView2222222 :: \(chatView.frame.origin.y)")
//        self.tableView.reloadData()
//      }
    }
      
    @objc private func keyboardWillHide(_ notification: Notification) {
//      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//        let keybaordRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keybaordRectangle.height
//        chatView.frame.origin.y += keyboardHeight
//
//        print("chatView111111 :: \(chatView.frame.origin.y)")
//        UIView.animate(withDuration: 0) {} completion: { (complete) in
//            if self.comments.count > 0 {
//                self.tableView.scrollToRow(at: IndexPath(item: self.comments.count-1, section: 0), at: .bottom, animated: true)
//            }
//        }
//
//        self.tableView.reloadData()
//      }
    }
    
    @objc func dissmissKeyboard(){
        self.view.endEditing(true)
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
