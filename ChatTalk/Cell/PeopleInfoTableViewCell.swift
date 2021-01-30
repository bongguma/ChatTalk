//
//  PeopleInfoTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/30.
//

import UIKit

class PeopleInfoTableViewCell: UITableViewCell {

    var userModel = UserModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setData(_ userModel:UserModel){
        self.userModel = userModel
    }
    
}
