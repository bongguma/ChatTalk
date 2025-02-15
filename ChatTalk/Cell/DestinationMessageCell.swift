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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 메세지 갯수만큼 서버에 방 인원 수를 물어보는 코드
    func setReadCount(_ comment : ChatModel.Comment, _ chatRoomUid : String){
        print("count DestinationMessageCell!!!!!!")
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
    
    public func setUiUpdate(_ comment : ChatModel.Comment, _ userModel: UserModel, _ chatRoomUid : String){

        nameLbl.text = userModel.name
        messageLbl.text = comment.message
        timeLbl.text = comment.time?.toDayTime
        
        let url = URL(string: userModel.profileImage!)
        
        setReadCount(comment, chatRoomUid)
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            DispatchQueue.main.sync {
//                self.profileImageView.image = UIImage(data: data!)
//            }
//        }.resume()
    }
}
