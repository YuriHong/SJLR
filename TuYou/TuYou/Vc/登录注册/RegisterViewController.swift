
//
//  RegisterViewController.swift
//  TuYou
//
//  Created by YU on 2019/5/28.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var registeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "注册"
        registeButton.setCorner(ViewCornerRadius)
        pwdTextField.isSecureTextEntry = true
        
    }

    @IBAction func registeAction(_ sender: Any) {
        guard let name = userNameTextField.text, let pwd = pwdTextField.text,
            pwd.count >= 6 else {
                HUDUtil.showInfo("密码位数必须高于5位数")
                return
        }
        HUDUtil.show()
        LCOperationUtil.registe(name: name, pwd: pwd) {[weak self] (ok, error) in
            HUDUtil.dismiss()
            if ok {
                self?.navigationController?.popViewController(animated: true)
            }else {
                print("注册失败")
                HUDUtil.showInfo("注册失败，请稍后再试")
            }
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
