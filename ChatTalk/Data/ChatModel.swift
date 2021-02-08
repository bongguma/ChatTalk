//
//  ChatModel.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/03.
//

import ObjectMapper

class ChatModel: Mappable {
    
    // 채팅방에 참여한 사람들
    public var users :Dictionary<String, Bool> = [:]
    
    // 채팅방에 대화내용
    public var comments :Dictionary<String, Comment> = [:]
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        users <- map["users"]
        comments <- map["comments"]
    }
    
    public class Comment : Mappable {
        
        public var uid: String?
        public var message: String?
        
        
        public required init?(map: Map) {}
        
        public func mapping(map: Map) {
            uid <- map["uid"]
            message <- map["message"]
        }
    }
}
