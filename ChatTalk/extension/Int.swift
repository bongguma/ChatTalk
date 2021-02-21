//
//  Int.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/21.
//

import UIKit

extension Int{
    
    var toDayTime : String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        
        return dateFormatter.string(from : date)
    }
}
