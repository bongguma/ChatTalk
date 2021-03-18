//
//  GroupChatViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/19.
//

import UIKit
import Firebase

class GroupChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value) { (datashapshot) in
            
            let dic = datashapshot.value as! [String:AnyObject]
            
            print("dic :: \(dic.count)")
        }
    }
    
}
