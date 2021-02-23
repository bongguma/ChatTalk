//
//  UserModel.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/29.
//

import UIKit

@objcMembers /* 이유를 모르겠으나 setValuesForKeys는 object-c 호환성이 필요 */
class UserModel: NSObject {
    var profileImage : String?
    
    var name : String?
    
    var uid : String?
    
    var pushToken : String?
    
    var comment : String?
}
