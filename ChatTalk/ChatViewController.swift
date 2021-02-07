//
//  ChatViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/03.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    var destinationUid: String? // 나중에 내가 채팅할 대상의 Uid
    var uid: String?
    var chatRoomUid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "채팅방"
        // Do any additional setup after loading the view.
    }

    @IBAction func sendAction(_ sender: Any) {
        // uid : 앱을 로그인한 유저에 대한 uid
        // destinationUid : 메신저를 받는 사람에 대한 uid
        let createRoomInfo:Dictionary<String, Any> = ["users" : [uid: true, destinationUid:true], "destinationUid" : destinationUid ]
        
        Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
    }

}
