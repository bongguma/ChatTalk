//
//  DestinationMessageCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/14.
//

import UIKit

class DestinationMessageCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
   
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(_ comment : ChatModel.Comment, _ userModel: UserModel){
        print("destinationMessageUIUpdate!!!!!!!!")
        nameLbl.text = userModel.name
        messageLbl.text = comment.message
        timeLbl.text = comment.time?.toDayTime
        let url = URL(string: userModel.profileImage!)
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            DispatchQueue.main.sync {
//                self.profileImageView.image = UIImage(data: data!)
//            }
//        }.resume()
    }
}
