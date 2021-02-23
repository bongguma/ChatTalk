//
//  AccountViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/02/23.
//


import UIKit
import Firebase

class AccountViewController: UIViewController{

    @IBOutlet weak var conditionsCommentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "상태 메세지", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "상태메세지를 입력해주세요."
        }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            
            if let textField = alertController.textFields?.first{
                let dic = ["comment":textField.text!]
                let uid = Auth.auth().currentUser?.uid
                Database.database().reference().child("users").child(uid!).updateChildValues(dic)
            }
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (action) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func conditionCommentAction(_ sender: Any) {
        showAlert()
    }
    
}
