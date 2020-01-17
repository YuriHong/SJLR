//
//  YKCSTabBarViewController.swift
//  YKCSSwift
//
//  Created by YU on 2018/12/10.
//  Copyright © 2018 Yu. All rights reserved.
//

import UIKit

class YKCSTabBarViewController: UITabBarController {

    private var isLogined: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        NotificationCenter.default.addObserver(self, selector: #selector(didLogined), name: LoginViewController.UserLogined, object: nil)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isLogined {
            let navi = UINavigationController(rootViewController: LoginViewController(nibName: "LoginViewController", bundle: nil))
            self.present(navi, animated: true, completion: nil)
        }
    }
    
    func setupUI() -> Void {
        let vcs: [UIViewController] = [TYHomeViewController(),
                                       TYMessageViewController(),
                                       TYMineViewController()]
        let titles = ["首页", "消息", "我的"]
        let images = ["首页", "消息", "我的"]
        for (index, item) in vcs.enumerated() {
            setupChildVC(vc: item, title: titles[index], image: images[index], selectedImage: images[index] + "_selected")
        }
    }
    
    private func setupChildVC(vc: UIViewController, title: String, image: String, selectedImage: String) {
        vc.view.backgroundColor = UIColor.white
        let navi = UINavigationController(rootViewController: vc)
//        navi.navigationBar.barStyle = .black
//        navi.navigationBar.isTranslucent = false
//        navi.navigationBar.setBackgroundImage(UIImage.image(with: UIColor.black), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        let item = UITabBarItem(title: title, image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: MainGray], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: MainGreen], for: .selected)
        navi.tabBarItem = item
        self.addChild(navi)
    }
    
    @objc func didLogined() {
        isLogined = true
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
