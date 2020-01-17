//
//  AppConfig.swift
//  TuYou
//
//  Created by YU on 2019/5/28.
//  Copyright © 2019 Yu. All rights reserved.
//

import Foundation
import UIKit


func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


///绿 82 239 154
let MainGreen: UIColor = RGBA(r: 82, g: 239, b: 154)
///暗灰 38 45 62
let MainGray: UIColor = RGBA(r: 38, g: 45, b: 62)
/// 253 77 83
let MainRed: UIColor = RGBA(r: 253, g: 77, b: 83)

///view cornerRadius
let ViewCornerRadius: CGFloat = 4.0

