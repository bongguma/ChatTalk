//
//  LoginViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/19.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func joinAction(_ sender: Any) {
//        let joinViewController = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
//        self.present(joinViewController, animated: true, completion: nil)
        
        let joinViewNavigationCont = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewNavigationCont")
        self.present(joinViewNavigationCont!, animated: true, completion: nil)
        
    }
    
}
