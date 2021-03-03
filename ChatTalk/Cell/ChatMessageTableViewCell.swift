//
//  ChatMessageTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/08.
//

import UIKit
import Firebase

class ChatMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var readMsgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setReadCount(_ comment : ChatModel.Comment, _ chatRoomUid : String){
        print("count ChatMessageTableViewCell!!!!!!")
        let readCount = comment.readUsers.count
        Database.database().reference().child("chatrooms").child(chatRoomUid).child("users").observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            
            let dic = datasnapshot.value as! [String:Any]
            
            let noReadCount = dic.count - readCount
            
            if noReadCount > 0 {
                self.readMsgLbl.isHidden = false
                self.readMsgLbl.text = String(noReadCount)
            } else {
                self.readMsgLbl.isHidden = true
            }
        }
    }
    
    public func setUiUpdate(_ comment : ChatModel.Comment){
        if nil != comment {
            messageLbl.text = comment.message!
            timeLbl.text = comment.time?.toDayTime
        }
        
    }

}
