//
//  LoginViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/19.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTxtF.text!, password: passwordTxtF.text!) { (loginResult, error) in
            if nil != error {
                let alert = UIAlertController(title: "로그인 에러", message: error.debugDescription, preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if nil != user {
                    let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    self.present(mainViewController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func joinAction(_ sender: Any) {
        
        let joinViewNavigationCont = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewNavigationCont")
        self.present(joinViewNavigationCont!, animated: true, completion: nil)
        
    }
    
}
