//
//  PeopleInfoTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/06.
//

import UIKit

class PeopleInfoTableViewCell: UITableViewCell {

    // 사용자 이미지
    @IBOutlet weak var peopleProfileIv: UIImageView!
    
    // 사용자 이름
    @IBOutlet weak var peopleNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(userModel: UserModel, _ data:Data){
        
        peopleProfileIv.image = UIImage(data: data)
        peopleProfileIv.layer.cornerRadius = (imageView?.frame.size.width)!/2
        
        peopleNameLbl.text = userModel.name
    }

}
