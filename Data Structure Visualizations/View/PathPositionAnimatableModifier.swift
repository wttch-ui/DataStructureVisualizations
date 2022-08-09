//
//  SwiftUIView.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/9.
//

import SwiftUI

///
/// 沿路径点变换位置的动画
///
struct PathPositionAnimatableModifier : AnimatableModifier {
    // 路径帮助类
    private var pathAnimationHelper: PathAnimationHelper
    // 当前位置占总路径的比例
    var rate: CGFloat = 0
    // 当前位置
    var curPos: CGPoint
    
    ///
    /// 构造位置路径动画
    /// 可以根据配置自动生成简单折线,
    ///
    /// - Parameters:
    ///   - p1: 开始位置
    ///   - p2: 结束位置
    ///   - rate: 当前位置所占总路径的比例
    ///   - offset: 折线向两边偏移的量
    ///   - usePath: 是否使用自动生成的折线
    ///
    init(_ p1: CGPoint, _ p2: CGPoint, rate: CGFloat = 0, usePath: Bool = true, offset: CGFloat = 40) {
        self.pathAnimationHelper = PathAnimationHelper.create(p1, p2, usePath: usePath)
        self.rate = rate
        self.curPos = p1
    }
    
    // 动画使用的值
    var animatableData: CGFloat {
        get { rate }
        set {
            rate = newValue
            // 重新计算位置
            curPos = self.pathAnimationHelper.curPos(rate)
        }
    }
    
    
    // 为 view 设置位置
    func body(content: Content) -> some View {
        content.position(
            curPos
        )
    }
    
}

