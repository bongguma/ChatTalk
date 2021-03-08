//
//  SelectFriendTableViewCell.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/03/05.
//


import UIKit
import Firebase
import BEMCheckBox

protocol SelectFriendProtocol {
    //프로토콜 정의
    func selectFriendCheckUsers() -> [String:Bool]
    
}

class SelectFriendTableViewCell: UITableViewCell, BEMCheckBoxDelegate,SelectFriendProtocol {
    
    var users = Dictionary<String, Bool>()
    
    var userModel = UserModel()
    
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
    }
    
    func selectFriendCheckUsers() -> [String : Bool] {
        print("users :: \(users)")
        return users
    }
}
