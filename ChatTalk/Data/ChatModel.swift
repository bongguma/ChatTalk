//
//  ChatModel.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/03.
//

import UIKit

class ChatModel: NSObject {
    
    // 채팅방에 참여한 사람들
    public var users :Dictionary<String, Bool> = [:]
    
    public var comments :Dictionary<String, Comment> = [:]
    
    public class Comment {
        public var uid: String?
        public var message: String?
    }
}
