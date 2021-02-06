//
//  JoinViewController.swift
//  ChatTalk
//
//  Created by 김예진 on 2021/01/20.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class JoinViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var nameTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var joinImageView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        joinImageView.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func plusJoinImageAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTxtF.text!, password: passwordTxtF.text!) { (user, error) in
            
            if let uid = user?.user.uid {
                let imageData = self.joinImageView.image!.jpegData(compressionQuality: 0.75)
                
                Storage.storage().reference().child("userImages").child(uid).putData(imageData!, metadata: nil) { (data, error) in
                    Storage.storage().reference().child("userImages").child(uid).downloadURL  { (image, error) in
                        let imageUrl = image!.absoluteURL.path
                        let values = ["name":self.nameTxtF.text!, "profileImage":imageUrl, "uid": Auth.auth().currentUser?.uid]
                        
                        Database.database().reference().child("users").child(uid).setValue(values)
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            } else {
                // 회원가입이 되지 않는 error 문구 생성 시키기
            }
        }
    }
    
}
