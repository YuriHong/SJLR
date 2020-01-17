//
//  LoginViewController.swift
//  TuYou
//
//  Created by YU on 2019/5/27.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit
import ChatKit
import SVProgressHUD

class LoginViewController: UIViewController {

    static let UserLogined: Notification.Name = Notification.Name(rawValue: "LoginedNotification")
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        loginButton.setCorner(ViewCornerRadius)
        registeButton.setCorner(ViewCornerRadius)
        pwdTextField.isSecureTextEntry = true
        
        
//        LCChatKit.sharedInstance()?.fetchProfilesBlock = { (userIds, completionHandler) in
//            guard let ids = userIds, ids.count > 0 else {
//                return
//            }
//            var users = [User]()
//            for id in ids {
//                let userQuery = AVQuery(className: "_User")
//                let user = userQuery.getObjectWithId(id)
//                if let u = user {
//                    let file = u.object(forKey: "avatar") as? AVFile
//                    let us = User(userId: u.objectId ?? "",
//                                 name: u.object(forKey: "username") as? String ?? "",
//                                 avatarURL: URL(string: file?.url() ?? "https://www.baidu.com")!, clientId: id)!
//                    users.append(us)
//                }else {
//                    let us = User(clientId: id)!
//                    users.append(us)
//                }
//            }
//            if let com = completionHandler {
//                com(users, nil)
//            }
//        }
    }

    @IBAction func loginOrRegisteAction(_ sender: UIButton) {
        
        if sender.tag == 0 {// 登录
            guard let name = userNameTextField.text, let pwd = pwdTextField.text,
                pwd.count >= 6 else {
                    HUDUtil.showInfo("密码位数必须高于5位数")
                    return
            }
            HUDUtil.show()
            LCOperationUtil.login(name: name, pwd: pwd) { (user, error) in
                guard error == nil else {
                    print(error!)
                    HUDUtil.dismiss()
                    HUDUtil.showInfo("用户未注册")
                    return
                }
                if let user = user {
                    print(user)
                    LCChatKit.sharedInstance()?.open(withClientId: user.objectId ?? "", callback: {[weak self] (ok, error) in
                        if ok {
                            self?.dismiss(animated: true, completion: nil)
                            NotificationCenter.default.post(name: LoginViewController.UserLogined, object: nil)
                        }else {
                            print(error!)
                        }
                        HUDUtil.dismiss()
                    })
                }
            }
        }else {// 注册
            self.navigationController?
                .pushViewController(RegisterViewController(nibName: "RegisterViewController", bundle: nil), animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
