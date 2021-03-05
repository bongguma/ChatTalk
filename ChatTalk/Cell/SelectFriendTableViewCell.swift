//
//  SelectFriendTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/05.
//


import UIKit
import Firebase
import BEMCheckBox

class SelectFriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var peopleImageIv: UIImageView!
    @IBOutlet weak var peopleNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(_ userModel : UserModel){
        peopleNameLbl.text = userModel.name
    }
}
