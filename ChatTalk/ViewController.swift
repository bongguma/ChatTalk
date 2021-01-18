//
//  ViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/18.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // 앱을 재배포하지 않고도 앱 내의 주요 변수들을 변경하여 업데이트 후, 테스트 진행
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfig.configSettings = remoteConfigSettings
        
        // 서버랑 연결이 되지 않을 경우, 디폴트 값을 보여준다.
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        // 서버통신 fetch가 성공해 값을 가져오는 부분
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
          if status == .success {
            print("Config 통신완료")
            self.remoteConfig.activate(completion: nil)
          } else {
            print("Config 통신실패")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
        // Do any additional setup after loading the view.
    }
    
    // remoteConfigDefaults 안에 있는 데이터를 가지고 화면 그리는 함수
    func displayWelcome() {
        let color = remoteConfig["splash_background"].stringValue

        let caps = remoteConfig["splash_message_caps"].boolValue

        let message = remoteConfig["splash_message"].stringValue

        print("caps :: \(caps)")
        
        if caps {
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                exit(0)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }


}

