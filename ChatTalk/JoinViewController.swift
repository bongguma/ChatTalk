//
//  JoinViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/20.
//

import UIKit
import Firebase
import FirebaseDatabase

class JoinViewController: UIViewController {
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var nameTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTxtF.text!, password: passwordTxtF.text!) { (user, error) in
            
            if let uid = user?.user.uid {
                print("uid?!!!!!!!!!")
                Database.database().reference().child("users").child(uid).setValue(["name":self.nameTxtF.text!])
            } else {
                // 회원가입이 되지 않는 error 문구 생성 시키기
            }
        }
    }
    
}
