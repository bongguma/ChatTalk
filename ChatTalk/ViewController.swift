//
//  ViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/18.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var remoteconfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteconfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfig.configSettings = remoteConfigSettings!
        
        // Do any additional setup after loading the view.
    }


}

