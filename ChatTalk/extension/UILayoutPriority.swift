//
//  UILayoutPriority.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/18.
//

import UIKit

extension UILayoutPriority {
    static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        let raw = lhs.rawValue + rhs
        return UILayoutPriority(rawValue:raw)
    }
}
