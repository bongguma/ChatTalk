//
//  MainViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/25.
//

import UIKit
import Firebase

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var peopleInfoArr:[UserModel] = []
    
    var myUid : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "친구목록"
        self.tableView.delegate = self
        self.tableView.dataSource = self

        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in

            // 현재 로그인 된 유저 uid 저장
            self.myUid = Auth.auth().currentUser?.uid
            
            self.peopleInfoArr.removeAll()
            
            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let userModel = UserModel()
                userModel.setValuesForKeys(snapChild.value as! [String:Any])
                if !(self.myUid?.elementsEqual(userModel.uid!))!{
                    self.peopleInfoArr.append(userModel)
                }
                
                self.tableView.reloadData()
            }
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let peopleInfoCell = tableView.dequeueReusableCell(withIdentifier: "PeopleInfoTableViewCell", for: indexPath) as! PeopleInfoTableViewCell
        
//        var profileImageUrl = peopleInfoArr[indexPath.row].profileImage!
//        print("profileImageUrl ::\(profileImageUrl)")
////        profileImageUrl.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
//        let gsReference = Storage.storage().reference(forURL:  peopleInfoArr[indexPath.row].profileImage!)
//                    print(gsReference.fullPath)//imageFolder/abc.jpg
//                    print(gsReference.bucket)//yourapp-206323.appspot.com
//                    print(gsReference.name)//abc.jpg
//                    gsReference.downloadURL(completion: { (url, error) in
//                        if let _url = url{
//                            print("_url::\(_url)")
//                            //use this _url in your any lazy loading third party library  and load image in your UITableViewCell
//                            //in my case is user Kingfisher third party lasy loading
//
//                        }
//        })
        
        URLSession.shared.dataTask(with: URL(string: "https://\(peopleInfoArr[indexPath.row].profileImage!)")!) { (data, response, error) in
            print("data :: \(data)")
            print("error :: \(error)")
            DispatchQueue.main.async {
                if nil != data {
                    peopleInfoCell.setUiUpdate(userModel: self.peopleInfoArr[indexPath.row], data!)
                } else {
                    peopleInfoCell.setUiUpdate(userModel: self.peopleInfoArr[indexPath.row], Data())
                }
            }
            
        }.resume()

        
        
        return peopleInfoCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextControllerView = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        
        nextControllerView?.destinationUid = self.peopleInfoArr[indexPath.row].uid
        
        self.navigationController?.pushViewController(nextControllerView!, animated: true)
    }
    
    @IBAction func showSelectFriendAction(_ sender: Any) {
//        self.performSegue(withIdentifier: "SelectFrindSegue", sender: nil)
        
        
        let nextControllerView = self.storyboard?.instantiateViewController(withIdentifier: "SelectFriendViewController") as? SelectFriendViewController
        self.navigationController?.pushViewController(nextControllerView!, animated: true)
    }
    
}
 
