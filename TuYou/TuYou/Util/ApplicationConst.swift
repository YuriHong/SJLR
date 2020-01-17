//
//  ApplicationConst.swift
//  TRSSwiftTemplate
//
//  Created by YU on 2018/11/29.
//  Copyright © 2018 TRS. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 状态栏

/// 刘海屏状态栏高度
let iPhoneXStatusHeight: CGFloat = 44.0
/// 非刘海屏状态栏高度
let iPhoneStatusHeight: CGFloat = 20.0
/// NaviBar高度
let iPhoneNaviBarHeight: CGFloat = 44.0
/// 导航栏整体高度（NaviBar + 状态栏）
let iPhoneNaviHeight: CGFloat = isiPhoneX ? (iPhoneXStatusHeight + iPhoneNaviBarHeight) : (iPhoneStatusHeight + iPhoneNaviBarHeight)

/// 是否刘海屏手机
let isiPhoneX: Bool = UIApplication.shared.statusBarFrame.size.height == iPhoneXStatusHeight ? true : false
/// 屏幕高度
fileprivate let iPhoneScreenHeight = UIScreen.main.bounds.size.height
/// 屏幕宽度
let iPhoneScreenWidth = UIScreen.main.bounds.size.width
/// iPhone X安全区域底部高度
fileprivate let iPhoneXBottomSafaAreaHeight: CGFloat = 34.0
/// iPhone X安全区域顶部高度 = 刘海屏状态栏高度
fileprivate let iPhoneXTopSafaAreaHeight: CGFloat = iPhoneXStatusHeight
/// TabBar高度
let iPhoneTabBarHeight: CGFloat = 49.0

// MARK: - 适配
/// 底部安全距离
let safeBottomMargin: CGFloat = isiPhoneX ? iPhoneXBottomSafaAreaHeight : 0.0
/// 有导航栏时顶部安全距离
let safeNaviBarTopMargin: CGFloat = iPhoneNaviHeight
/// 无导航栏时顶部安全距离
let safeTopMargin: CGFloat = isiPhoneX ? iPhoneXTopSafaAreaHeight : 0.0
/// 屏幕的安全区域高度
let iPhoneScreenSafeAreaHeight = isiPhoneX ? (iPhoneScreenHeight - iPhoneXStatusHeight - iPhoneXBottomSafaAreaHeight) : iPhoneScreenHeight


// MARK: - 适配
func ScaleW(_ w: CGFloat) -> CGFloat {
    return w / 375.0 * iPhoneScreenWidth
}

func ScaleH(_ h: CGFloat) -> CGFloat {
    return h / 667.0 * iPhoneScreenHeight
}

/// 按宽比例缩放size
///
/// - Parameter size: 标注size
/// - Returns: 缩放后size
func ScaleSize(_ size: CGSize) -> CGSize {
    return CGSize(width: ScaleW(size.width), height: ScaleW(size.height))
}

/// CGFloat 向上取整
///
/// - Parameter value: 取整前的值
/// - Returns: 取整后的值
func FloatCeil(_ value: CGFloat) -> CGFloat {
    return CGFloat(ceil(Double(value)))
}

/// CGFloat 向下取整
///
/// - Parameter value: 取整前的值
/// - Returns: 取整后的值
func FloatFloor(_ value: CGFloat) -> CGFloat {
    return CGFloat(floor(Double(value)))
}

/// 按宽度之比缩放图片
///
/// - Parameters:
///   - size: 图片size
///   - w: 宽度标准
/// - Returns: 缩放后size
func ScaleImageSize(_ size: CGSize, w: CGFloat) -> CGSize {
    let s = w / size.width
    let h = size.height * s
    return CGSize(width: w, height: FloatFloor(h))
}

