//
//  Util.swift
//  NewFoodSwift
//
//  Created by YU on 2017/7/7.
//  Copyright © 2017年 YU. All rights reserved.
//

import Foundation
//import SwiftyJSON
import SVProgressHUD
//import RxSwift
//import Moya



// MARK: - 网络请求数据处理

/// 完成操作 ok: true = 成功解析数据，res：若OK = true 则返回数据 若ok = false则为Any  msg:错误String信息若ok=true则为“”
//typealias CompleteHandler = ((_ ok: Bool, _ res: Any, _ msg: String) -> ())
//
//let disposebag = DisposeBag()
//
//class NetworkUtil {
//
//    /// 获取文化创意二级分类下数据
//    ///
//    /// - Parameters:
//    ///   - id: 分类id
//    ///   - completion: 完成操作
//    static func childGoodsInfo(id: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .childGoods(id: id)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let p = BoutiquePushData.deserialize(from: json["data"].dictionaryObject) ?? BoutiquePushData()
//            completion(ok, p, msg)
//        }
//    }
//
//    /// 获取文化创意一级分类下数据
//    ///
//    /// - Parameters:
//    ///   - id: 分类id
//    ///   - completion: 完成操作
//    static func gerGoods(id: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .gerGoods(id: id)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//             let p = BoutiquePushData.deserialize(from: json["data"].dictionaryObject) ?? BoutiquePushData()
//            completion(ok, p, msg)
//        }
//    }
//
//    /// 获取用户信息 若返回502 则用户信息过期或者已在他处登录 需要重新登录
//    ///
//    /// - Parameter completion: 完成后操作
//    static func requestUserInfo(completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .userInfo, complete: completion)
//    }
//
//    /// 获取推送中的文章列表
//    static func originArtical(page: Int, limit: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .originArticleList(page: page, limit: limit)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]["list"]
//            let product = [BoutiqueProduct].deserialize(from: data.arrayObject) ?? []
//            completion(true, product, msg)
//        }
//    }
//
//    /// 获取文创推送数据
//    ///
//    /// - Parameters:
//    ///   - page: 页数
//    ///   - limit: 每页条数
//    ///   - completion: 完成操作
//    static func originList(page: Int, limit: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .originIndex(page: page, limit: limit)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = OriginHome.deserialize(from: data.dictionaryObject) ?? OriginHome()
//            completion(true, product, msg)
//        }
//    }
//
//
//    /// 获取大羌产业商品详情
//    ///
//    /// - Parameters:
//    ///   - id: id
//    ///   - completion: 完成操作
//    static func industrProductInfo(id: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .industrProductInfo(id: id)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = BoutiqueProduct.deserialize(from: data.dictionaryObject) ?? BoutiqueProduct()
//            completion(true, product, msg)
//        }
//    }
//
//    /// 大羌产业产品数据
//    ///
//    /// - Parameters:
//    ///   - page: 页数
//    ///   - limit: 每页
//    ///   - pid: id
//    ///   - completion: 完成操作
//    static func industrIndex(page: Int, limit: Int, pid: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .industrIndex(page: page, limit: limit, pid: pid)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let list = json["data"]["list"]
//            let data = [Artical].deserialize(from: list.arrayObject) ?? []
//            completion(ok, data, msg)
//        }
//    }
//
//    /// 获取文章详情
//    ///
//    /// - Parameters:
//    ///   - id: id
//    ///   - completion: 完成操作
//    static func articleProductInfo(type: ArticleType, completion: @escaping CompleteHandler) {
//        var api = API.userInfo
//        switch type {
//        case .push(let id):
//            api = .originArticleDetail(id: id)
//        case .culture(let id):
//            api = .articleList(id: "\(id)")
//        }
//        NetworkUtil.unifiedProcessingRequest(api: api) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = BoutiqueProduct.deserialize(from: data.dictionaryObject) ?? BoutiqueProduct()
//            completion(true, product, msg)
//        }
//    }
//
//    /// 获取大羌文化的文章数据
//    ///
//    /// - Parameters:
//    ///   - page: 页数
//    ///   - limit: 每页条数
//    ///   - pid: id
//    ///   - completion: 完成操作
//    static func getArticle(page: Int, limit: Int, pid: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .getArticle(page: page, limit: limit, id: pid)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let list = json["data"]["list"]
//            let data = [Artical].deserialize(from: list.arrayObject) ?? []
//            completion(ok, data, msg)
//        }
//    }
//
//    /// 获取单条文创推送产品信息
//    ///
//    /// - Parameters:
//    ///   - id: 产品ID
//    ///   - completion: 完成操作
//    static func pushProductDetail(id: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .originGetOne(id: id)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = BoutiqueProduct.deserialize(from: data.dictionaryObject) ?? BoutiqueProduct()
//            completion(true, product, msg)
//        }
//    }
//
//    /// 获取文创产品详情
//    ///
//    /// - Parameters:
//    ///   - id: id
//    ///   - completion: 完成操作
//    static func productDetail(id: Int, completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .productList(id: "\(id)")) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = BoutiqueProduct.deserialize(from: data.dictionaryObject) ?? BoutiqueProduct()
//            completion(true, product, msg)
//        }
//    }
//
//    /// 获取文创产品数据
//    ///
//    /// - Parameters:
//    ///   - page: 页数
//    ///   - limit: 每页
//    ///   - pid: id
//    ///   - completion: 完成操作
//    static func getProduct(page: Int, limit: Int, pid: Int, completion: @escaping CompleteHandler) -> Void {
//        NetworkUtil.unifiedProcessingRequest(api: .product(page: page, limit: limit, pid: pid)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let list = json["data"]["list"]
//            let data = [Artical].deserialize(from: list.arrayObject) ?? []
//            completion(ok, data, msg)
//        }
//    }
//
//    /// 重置密码
//    ///
//    /// - Parameters:
//    ///   - name: 用户名
//    ///   - code: 短信验证码
//    ///   - pwd: 密码
//    ///   - completion: 完成操作
//    static func resetPassword(name: String, code: String, pwd: String, completion: @escaping CompleteHandler) {
//        guard Util.check(type: .phone(name)),
//            Util.check(type: .smsCode(code)),
//            Util.check(type: .pwd(pwd)) else {
//                return
//        }
//        NetworkUtil.unifiedProcessingRequest(api: .updatePwd(name: name, code: code, pwd: pwd)) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            completion(ok, json, msg)
//        }
//    }
//
//    /// 获取我的关注或者收藏
//    ///
//    /// - Parameters:
//    ///   - isAttention: true 获取关注
//    ///   - page: 页数
//    ///   - limit: 每页条数
//    ///   - completion: 完成操作
//    static func mineAttentionOrCollect(isAttention: Bool, page: Int, limit: Int, completion: @escaping CompleteHandler) {
//        var api: API
//        if isAttention {
//            api = .meStar(page: page, limit: limit)
//        }else {
//            api = .meCollect(page: page, limit: limit)
//        }
//        NetworkUtil.unifiedProcessingRequest(api: api) { (ok, res, msg) in
//            guard ok else {
//                completion(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                completion(ok, res, msg)
//                return
//            }
//            let data = json["data"]["list"]
//            let home = [StarCollectionData].deserialize(from: data.arrayObject) ?? []
//            completion(true, home, "")
//        }
//    }
//
//    /// 关注或者取消关注收藏与取消
//    ///
//    /// - Parameters:
//    ///   - isAttention: true 是关注事件
//    ///   - type: 参数type 商品类型
//    ///   - gid: 商品id
//    ///   - service: 操作的服务 add添加，其余如任意参数删除
//    ///   - completion: 完成操作
//    static func attentionOrCollect(isAttention: Bool, type: ProductType, gid: String, service: SeriviceType,completion: @escaping CompleteHandler) {
//        var api: API
//        if isAttention {
//            api = .homeStar(type: type.rawValue, gid: gid, service: service)
//        }else {
//            api = .homeCollect(type: type.rawValue, gid: gid, service: service)
//        }
//        NetworkUtil.unifiedProcessingRequest(api: api) { (ok, res, msg) in
//            completion(ok, res, msg)
//        }
//    }
//
//    /// 搜索
//    ///
//    /// - Parameters:
//    ///   - key: 关键字
//    ///   - complete: 完成操作
//    static func searchInfo(key: String, complete: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .homeSearch(key: key)) { (ok, res, msg) in
//            guard ok else {
//                complete(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                complete(ok, res, msg)
//                return
//            }
//            let list = json["data"]["list"]
//            let data = [BoutiqueProduct].deserialize(from: list.arrayObject) ?? []
//            complete(ok, data, msg)
//        }
//    }
//
//    /// 获取首页数据
//    ///
//    /// - Parameter complete: 完成操作
//    static func homeIndex(complete: CompleteHandler?) {
//        NetworkUtil.unifiedProcessingRequest(api: .homeIndex) { (ok, res, msg) in
//            guard ok else {
//                complete?(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                complete?(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let home = HomeModel.deserialize(from: data.dictionaryObject) ?? HomeModel()
//            DLog(home)
//            complete?(true, home, "")
//        }
//    }
//
//    /// 获取全部精品或者全部文创产品
//    ///
//    /// - Parameter complete: 完成操作
//    static func boutiqueList(complete: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .boutiqueIndex) { (ok, res, msg) in
//            guard ok else {
//                complete(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                complete(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let list = BoutiquePushData.deserialize(from: data.dictionaryObject) ?? BoutiquePushData()
//            complete(true, list, "")
//        }
//    }
//
//    ///  获取精品详情
//    ///
//    /// - Parameters:
//    ///   - id: id
//    ///   - complete: 完成操作
//    static func boutiqueInfo(id: Int, complete: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .boutiqueGetList(id: String(id))) { (ok, res, msg) in
//            guard ok else {
//                complete(ok, res, msg)
//                return
//            }
//            guard let json = res as? JSON else {
//                complete(ok, res, msg)
//                return
//            }
//            let data = json["data"]
//            let product = BoutiqueProduct.deserialize(from: data.dictionaryObject) ?? BoutiqueProduct()
//            complete(true, product, msg)
//        }
//    }
//
//
//    /// 更新用户信息
//    ///
//    /// - Parameters:
//    ///   - head: 用户头像
//    ///   - nickName: 用户昵称
//    ///   - complete: 完成操作
//    static func updateUserInfo(head: String?, nickName: String?, complete: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .update_info(head: head, nick: nickName)) { (ok, res, msg) in
//            complete(ok, res, msg)
//        }
//    }
//
//    /// 统一处理网络请求
//    ///
//    /// - Parameters:
//    ///   - api: 接口
//    ///   - complete: 完成操作
//    static func unifiedProcessingRequest(api: API, complete: CompleteHandler?) {
//        let provider = MoyaProvider<API>()
//        provider.rx.request(api)
//            .asObservable()
//            .showHUD()
//            .subscribe({ (event) in
//                NetworkUtil.displayData(event: event, completeHandler: { (ok, res, msg) in
//                    guard ok else {
//                        complete?(ok, res, msg)
//                        return
//                    }
//                    let (success, json, msg) = NetworkUtil.processing(data: res)
//                    complete?(success, json, msg)
//                })
//            }).disposed(by: disposebag)
//    }
//
//    /// 注册
//    ///
//    /// - Parameters:
//    ///   - code: 验证码
//    ///   - name: 电话号码
//    ///   - pwd: 密码
//    ///   - complete: 完成操作
//    static func registe(code: String, name: String, pwd: String, complete: CompleteHandler?) {
//        guard Util.check(type: .phone(name)),
//            Util.check(type: .smsCode(code)),
//            Util.check(type: .pwd(pwd)) else {
//            return
//        }
//
//        NetworkUtil.unifiedProcessingRequest(api: .reg(code: code, name: name, pwd: pwd)) { (ok, res, msg) in
//            guard ok else {
//                complete?(ok, res, msg)
//                return
//            }
//            complete?(ok, res, "注册成功")
//        }
//    }
//
//    static func lougout(completion: @escaping CompleteHandler) {
//        NetworkUtil.unifiedProcessingRequest(api: .logout, complete: completion)
//    }
//
//    /// 登录
//    ///
//    /// - Parameters:
//    ///   - phone: 电话号码
//    ///   - pwd: 密码 不少于6位
//    static func login(type: UserAction,phone: String, pwd: String? = nil, code: String? = nil, complete: CompleteHandler?) {
//        guard Util.check(type: .phone(phone)) else {
//            return
//        }
//        var api: API
//        switch type {
//        case .login:
//            if let p = pwd, Util.check(type: .pwd(p)) {
//                api = .login(name: phone, pwd: p, code: nil)
//            }else {
//                return
//            }
//        case .forgetPassword:
//            if let c = code, Util.check(type: .smsCode(c)) {
//                api = .login(name: phone, pwd: nil, code: c)
//            }else {
//                return
//            }
//        }
//
//        NetworkUtil.unifiedProcessingRequest(api: api) { (ok, res, msg) in
//            guard ok else {
//                complete?(ok, res, msg)
//                return
//            }
//            if let json = res as? JSON {
//                let user = User.share
//                user.token = json["token"].rawString() ?? ""
//                user.exp = TimeInterval(json["exp"].numberValue.intValue)
//                user.id = json["data"]["id"].numberValue.intValue
//                user.head = json["data"]["head"].rawString() ?? ""
//                user.name = json["data"]["name"].rawString() ?? ""
//                user.nickname = json["data"]["nickname"].rawString() ?? ""
//                user.password = json["data"]["password"].rawString() ?? ""
//                user.saveToDisk()
//                complete?(true, user, "登录成功")
//            }else {
//                complete?(false, res, "登录失败")
//            }
//        }
//    }
//
//    /// 发送验证码
//    ///
//    /// - Parameters:
//    ///   - type: SMSType
//    ///   - phone: 电话号码
//    static func sendSMS(type: SMSType, phone: String, complete: CompleteHandler?) {
//        guard Util.check(type: .phone(phone)) else {
//            return
//        }
//        NetworkUtil.unifiedProcessingRequest(api: .sendSMS(type: type, phone: phone)) { (ok, res, msg) in
//            complete?(ok, res, msg)
//        }
//    }
//
//    /// 对获取到的网络数据进行初步处理
//    ///
//    /// - Parameters:
//    ///   - api: 接口名
//    ///   - event: Event<Response>
//    ///   - completeHandler: 完成后操作
//    static public func displayData(_ api: String = "", event: Event<Response>, completeHandler: CompleteHandler?) -> Void {
//        switch event {
//        case let .next(response):
//            do {
//                let jsonData = try JSON(data: response.data)
//                if let complete = completeHandler {
//                    DispatchQueue.main.async(execute: {
//                        complete(true, jsonData, "")
//                    })
//                }
//            } catch {
//                if let complete = completeHandler {
//                    DispatchQueue.main.async(execute: {
//                        DLog("数据解析错误\(error)")
//                        complete(false, "", "数据解析错误\(error)")
//                    })
//                }
//            }
//        case let .error(error):
//            if let complete = completeHandler {
//                DispatchQueue.main.async(execute: {
//                    //
//                    DLog("网络错误\(error)")
//                    complete(false, "", "网络错误\(error)")
//                })
//            }
//        default:
//            break;
//        }
//    }
//
//    /// 检查返回JSON数据是否为成功返回的数据 code  = 200
//    ///
//    /// - Parameter json: JSON序列化后的数据
//    /// - Returns: (Bool, String) true = 正确
//    static public func processing(data: Any) -> (Bool, Any, String) {
//
//        guard let js = data as? JSON else {
//            DLog("JSON转换失败")
//            return (false, JSON(), "未知错误")
//        }
//
//        if js["code"] == 200 {
//            return (true, js, js["msg"].rawString() ?? "")
//        }else if js["code"] == 502 {
//            return (false, js, js["msg"].rawString() ?? "登录过期，需重新登录")
//        }else if js["code"] == 501 {
//            let msg = js["msg"].rawString() ?? "未知错误"
//            DLog(msg)
//            return (false, js, msg)
//        }
//        DLog("其他错误")
//        return (false, js, "未知错误")
//    }
//
//}

// MARK: - 辅助开发 常用方法

//class Util {
//    /// 检验类型
//    enum CheckType {
//        /// 电话号码
//        case phone(String)
//        /// 密码
//        case pwd(String)
//        /// 短信验证码
//        case smsCode(String)
//    }
//    static func check(type: CheckType) -> Bool {
//        switch type {
//        case .phone(let p):
//            if p.count == 11 {
//                return true
//            }
//            HUDUtil.showError("请输入正确的手机号")
//        case .pwd(let p):
//            if p.count >= 6 {
//                return true
//            }
//            HUDUtil.showError("密码位数不少于6位")
//        case .smsCode(let s):
//            if s.count == 4 {
//                return true
//            }
//            HUDUtil.showError("验证码错误")
//        }
//        return false
//    }
//}


// MARK: - 设置SVProgressHUD样式

class HUDUtil {
    
    static let MinimumTime: TimeInterval = 1.5
    
    static func defaultConfigure() {
        SVProgressHUD.setMinimumDismissTimeInterval(MinimumTime)
        SVProgressHUD.setMinimumSize(CGSize(width: 40, height: 40))
        SVProgressHUD.setDefaultMaskType(.gradient)
    }
    
    static func showInfo(_ msg: String, delay: TimeInterval, completion: @escaping SVProgressHUDDismissCompletion) {
        HUDUtil.showInfo(msg, time: delay)
        SVProgressHUD.dismiss(withDelay: delay, completion: completion)
    }
    
    static func showInfo(_ msg: String, time: TimeInterval = MinimumTime) -> Void {
        HUDUtil.defaultConfigure()
        SVProgressHUD.showInfo(withStatus: msg)
    }
    static func showError(_ msg: String, time: TimeInterval = MinimumTime) -> Void {
        HUDUtil.defaultConfigure()
        SVProgressHUD.showError(withStatus: msg)
    }
    
    static func showSuccess(_ msg: String, time: TimeInterval = MinimumTime) -> Void {
        HUDUtil.defaultConfigure()
        SVProgressHUD.showSuccess(withStatus: msg)
    }
    
    static func show() {
        SVProgressHUD.show()
    }
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
}

//自定义调试阶段log
func DLog<T>(_ msg: T, filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print("[DEBUG " + "\(fileName)" + ":" + " \(rowCount)]" + " \(msg)" + "\n")
    #endif
}


//extension Observable {
//
//    func showHUD() -> Observable<Element> {
//        return self.do(onNext: { (event) in
//            DLog(event)
//            DLog("onNext")
//        }, onError: { (error) in
//            DispatchQueue.main.async(execute: {
//                //
//                #if DEBUG
////                HUDUtil.showError("请求出错！error: \(error)")
//                #endif
//            })
//            DLog(error)
//            DLog("onError")
//        }, onCompleted: {
//            SVProgressHUD.dismiss()
//            DLog("onCompleted")
//        }, onSubscribe: {
//            DLog("onSubscribe")
//        }, onSubscribed: {
//            SVProgressHUD.show()
//            DLog("onSubscribed")
//        }, onDispose: {
//            SVProgressHUD.dismiss()
//            DLog("onDispose")
//        })
//    }
//}

func excute(_ msg: String = "", action: () -> ()) -> Void {
    DLog("Excute begin: \(msg)")
    action()
    DLog("Excute end: \(msg)")
}

//
//func loadViewFormNib(_ name: String) -> UIView {
//    return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! UIView
//}

