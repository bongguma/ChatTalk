//
//  ChatRowCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/21.
//

import UIKit
import Firebase

class ChatRowCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var lastMessageLbl: UILabel!
    
    @IBOutlet weak var lastMessageTimeLbl: UILabel!
    
    var destinationUid : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(_ chatRoom : ChatModel, _ uid : String){
        for item in chatRoom.users {
            if (item.key != uid) {
                destinationUid = item.key
            }
        }
        
        Database.database().reference().child("users").child(destinationUid!).observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            let userModel = UserModel()
            userModel.setValuesForKeys(datasnapshot.value as! [String:AnyObject])
            
            if chatRoom.comments.keys.count == 0 {
                return 
            }
            
            self.titleLbl.text = userModel.name!
            
            let lastMesageKey = chatRoom.comments.keys.sorted(){$0>$1}
            self.lastMessageLbl.text = chatRoom.comments[lastMesageKey[0]]?.message
            let unixTime = chatRoom.comments[lastMesageKey[0]]?.time
             
            self.lastMessageTimeLbl.text = unixTime?.toDayTime
        }
    }
}
