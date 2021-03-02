//
//  DestinationMessageCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/14.
//

import UIKit
import Firebase

class DestinationMessageCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
   
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var readMsgLbl: UILabel!
    
    var chatRoomUid : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setReadCount(_ comment : ChatModel.Comment){
        let readCount = comment.readUsers.count
        Database.database().reference().child("chatrooms").child(chatRoomUid!).child("users").observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            
            let dic = datasnapshot.value as! [String:Any]
            
            let noReadCount = dic.count - readCount
            
            if noReadCount > 0 {
                readMsgLbl.isHidden = false
                readMsgLbl.text = String(noReadCount)
            } else {
                readMsgLbl.isHidden = true
            }
        }
    }
    
    public func setUiUpdate(_ comment : ChatModel.Comment, _ userModel: UserModel, _ chatRoomUid : String){
        print("destinationMessageUIUpdate!!!!!!!!")
        nameLbl.text = userModel.name
        messageLbl.text = comment.message
        timeLbl.text = comment.time?.toDayTime
        
        let url = URL(string: userModel.profileImage!)
        
        self.chatRoomUid = chatRoomUid
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            DispatchQueue.main.sync {
//                self.profileImageView.image = UIImage(data: data!)
//            }
//        }.resume()
    }
}
