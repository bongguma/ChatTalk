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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendAction(_ sender: Any) {
        let createRoomInfo = ["uid" : Auth.auth().currentUser?.uid,
                              "destinationUid" : destinationUid
        ]
        
        Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
