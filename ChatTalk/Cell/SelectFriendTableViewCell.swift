//
//  SelectFriendTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/05.
//


import UIKit
import Firebase
import BEMCheckBox

// 데이터를 보낼 쪽에서 protocol를 선언하고 delegate를 선언한다.
protocol SelectFriendProtocol {
    //프로토콜 정의
    func selectFriendCheckUsers(users : [String:Bool])
    
}

class SelectFriendTableViewCell: UITableViewCell, BEMCheckBoxDelegate {
    
    var users = Dictionary<String, Bool>()
    
    var userModel = UserModel()
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var peopleImageIv: UIImageView!
    @IBOutlet weak var peopleNameLbl: UILabel!
    
    var delegate : SelectFriendProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUiUpdate(_ userModel : UserModel, _ row : Int, _ users:[String:Bool]){
        
        self.users = users
        self.userModel = userModel
        
        peopleNameLbl.text = userModel.name
        
        checkBox.delegate = self
        checkBox.tag = row
        
    }
    
    @IBAction func didTapAction(_ sender: Any) {
            if checkBox.on {
                users[userModel.uid!] = true
            } else {
                users.removeValue(forKey: userModel.uid!)
            }
        self.delegate?.selectFriendCheckUsers(users: users)
    }
//
//    func selectFriendCheckUsers() -> [String : Bool] {
//        print("users :: \(users)")
//        return users
//    }
}
