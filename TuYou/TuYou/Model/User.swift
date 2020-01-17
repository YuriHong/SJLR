//
//  User.swift
//  TuYou
//
//  Created by YU on 2019/5/27.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit
import ChatKit

final class User: NSObject, LCCKUserDelegate {
    init!(userId: String!, name: String!, avatarURL: URL!) {
        super.init()
        self.userId = userId
        self.userName = name
        self.userAvatar = avatarURL.absoluteString
    }
    
    init!(clientId: String!) {
        super.init()
        self.clientId = clientId
    }
    
    
    var userId: String = ""
    var userName: String = ""
    var userAvatar: String = ""
    var userClientId: String = ""

    required init?(coder aDecoder: NSCoder) {
        super.init()
        userId = aDecoder.value(forKey: "userId") as? String ?? ""
        userName = aDecoder.value(forKey: "name") as? String ?? ""
        userAvatar = aDecoder.value(forKey: "avatarURL") as? String ?? "https://www.baidu.com"
        userClientId = aDecoder.value(forKey: "clientId") as? String ?? ""
    }
    
    required init!(userId: String!, name: String!, avatarURL: URL!, clientId: String!) {
        super.init()
        self.userId = userId
        userName = name
        userAvatar = avatarURL.absoluteString
        userClientId = clientId
    }
    
    static func user(withUserId userId: String!, name: String!, avatarURL: URL!, clientId: String!) -> User {
        return User(userId: userId, name: name, avatarURL: avatarURL, clientId: clientId)
    }
    
    var clientId: String! {
        get {
            return userClientId
        }
        set(clientId) {
            userClientId = clientId
        }
    }
    
    var name: String {
        return userName
    }
    
    /*!
     * @brief User's avatar URL.
     */
    var avatarURL: URL {
        return URL(string: userAvatar) ?? URL(string: "https://www.baidu.com")!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatarURL, forKey: "avatarURL")
        aCoder.encode(clientId, forKey: "clientId")
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User.init(userId: userId, name: userName, avatarURL: URL(string: userAvatar)!, clientId: clientId)!
    }
    
}
