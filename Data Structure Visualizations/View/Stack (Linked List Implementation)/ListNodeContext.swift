//
//  ListNodeContext.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/15.
//

import Combine
import SwiftUI

///
/// 节点上下文数据
///
public class ListNodeContext {
    // 节点的数据值
    var value: Int
    // 节点索引, 越小越靠后
    var index: Int
    
    private let position = CGPoint(x: 100, y: 100)
    private let hCount = 6
    
    init(value: Int, index: Int) {
        self.value = value
        self.index = index
    }

    ///
    /// 获取当前元素的偏移量
    ///
    /// 第count-1个元素，也就是新增的，单独配置移动轨迹
    ///
    /// - Parameters:
    ///   - count 总元素个数
    /// - Returns: 当前元素动画的偏离量
    ///
    func offsetValue(count: Int) -> CGSize {
        // 就是正数 1...count
        // 因为偏移是稍微预支下一个元素的
        let newIndex = count - index
        if newIndex % 6 == 0 {
            return CGSize(width: -100 * 5, height: 80)
        } else {
            return CGSize(width: 100, height: 0)
        }
    }
    
    ///
    /// 获取当前元素的位置
    ///
    /// - Parameters:
    ///   - count: 总元素个数
    /// - Returns: 当前元素位置
    ///
    func position(count: Int) -> CGPoint {
        // 就是正数 0...count - 1
        let newIndex = count - index - 1
        return CGPoint(x: CGFloat(newIndex % 6) * 100.0 + 100 , y: CGFloat(newIndex / 6) * 80 + 240)
    }    ///
    
    ///
    /// 获取添加元素后当前元素的箭头所指的位置
    ///
    /// - Parameters:
    ///   - count: 总元素个数
    /// - Return: 当前元素位置
    ///
    func linkEndPosition(count: Int) -> CGPoint? {
        // 就是正数 1...count
        let newIndex = count - index + 2
        return CGPoint(x: CGFloat(newIndex % 6) * 100.0 + 100 , y: CGFloat(newIndex / 6) * 80 + 240)
    }
}

extension ListNodeContext : Identifiable {
    public var id: Int {
        index
    }
}
