//
//  LCOperationUtil.swift
//  TuYou
//
//  Created by YU on 2019/5/27.
//  Copyright © 2019 Yu. All rights reserved.
//

import Foundation
import ChatKit
import LeanCloud

class LCOperationUtil: NSObject {
    
    /// 注册
    ///
    /// - Parameters:
    ///   - name: 用户名
    ///   - pwd: 密码
    ///   - complete: 完成操作
    class func registe(name: String, pwd: String, complete: AVBooleanResultBlock?) -> Void {
        let user = AVUser()
        user.username = name
        user.password = pwd
        user.signUpInBackground(complete ?? {(_,_)in
            user.save()
            })
    }
    
    /// 登录
    ///
    /// - Parameters:
    ///   - name: 用户名
    ///   - pwd: 密码
    ///   - complete: 完成操作
    class func login(name: String, pwd: String, complete: AVUserResultBlock?) {
        AVUser.logInWithUsername(inBackground: name, password: pwd, block: complete ?? {(_, _)in})
    }
}

