//
//  ChatMessageTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/08.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(_ comment : ChatModel.Comment){
        if nil != comment {
            messageLbl.text = comment.message!
        }
        
    }

}
