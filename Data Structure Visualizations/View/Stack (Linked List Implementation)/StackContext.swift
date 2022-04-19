//
//  StateContext.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/18.
//

import SwiftUI
import Combine

class StackContext: ObservableObject {
    // 栈元素保存的位置
    var list: [ListNodeContext] = []
    // 记录每个单元格的位置信息，每次新增的时候都在后面添加一个位置，根据规则直接往后排
    // 第 i 的元素的位置在改数组的 list.count - i - 1 的位置
    // 画线和定位的时候会用到该值
    fileprivate var position: [CGPoint] = []
    // 动画偏移数组，每个节点都有一个对应的值，用来动画时偏移使用
    @Published var animationOffset: [CGSize] = []
    // 画线结束数组，每个节点都有一个对应的值，用来说明画线动画结束的位置
    @Published var animationLinkEnd: [CGPoint] = []

    init() {
        position.append(newPosition(0))
    }

    ///
    /// 新增一个数据节点
    ///
    /// - Parameter value: 数据节点的值
    func newNode(_ value: Int) {
        let node = ListNodeContext(value: value, context: self)
        list.append(node)
        position.append(newPosition(list.count))
        animationOffset.append(CGSize.zero)
        // 为第一个元素以外的元素添加箭头动画的值
        if list.count != 1 {
            animationLinkEnd.append(CGPoint(x: 200, y: 240))
        }

        // 重置所有动画偏移
        for i in 0..<animationOffset.count {
            animationOffset[i] = CGSize.zero
        }
    }


    ///
    /// 新增一个元素的所在位置
    ///
    /// - Returns: 新增元素的位置
    ///
    private func newPosition(_ index: Int) -> CGPoint {
        CGPoint(x: CGFloat(index % 6) * 100.0 + 100, y: CGFloat(index / 6) * 80 + 240)
    }

    ///
    /// 入栈时的移动和画线的动画
    ///
    func enterMoveAnimation() {
        list.forEach { ctx in
            animationOffset[ctx.index] = ctx.enterAnimationOffset()
            let linkEndPosition = ctx.linkEndAnimationTarget()
            if ctx.index > 0 && linkEndPosition != nil {
                animationLinkEnd[ctx.index - 1] = linkEndPosition!
            }
        }
    }
}


///
/// 节点上下文数据
///
public class ListNodeContext {
    // 节点的数据值
    var value: Int
    // 节点索引, 越小越靠后
    var index: Int

    private let hCount = 6

    private var context: StackContext = StackContext()

    init(value: Int, context: StackContext) {
        self.value = value
        self.context = context
        self.index = context.list.count
    }

    init(value: Int, index: Int) {
        self.value = value
        self.index = index
    }

    ///
    /// 获取当前元素的入栈动画时的偏移量
    ///
    /// 第count-1个元素，也就是新增的，单独配置移动轨迹
    ///
    /// - Returns: 当前元素动画的偏离量
    ///
    func enterAnimationOffset() -> CGSize {
        // 就是正数 1...count
        // 因为偏移是稍微预支下一个元素的
        let newIndex = context.list.count - index
        var offset: CGSize
        if newIndex % 6 == 0 {
            offset = CGSize(width: -100 * 5, height: 80)
        } else {
            offset = CGSize(width: 100, height: 0)
        }
        return offset
    }

    ///
    /// 获取当前元素的位置
    ///
    /// - Returns: 当前元素位置
    ///
    func position() -> CGPoint {
        // 就是正数 0...count - 1
        let newIndex = context.list.count - index - 1
        return context.position[newIndex]
    }

    func linkEndPosition() -> CGPoint? {
        if index == 0 {
            return nil
        }
        return context.animationLinkEnd[index - 1]
    }

    ///
    /// 获取添加元素后当前元素的箭头所指的位置
    ///
    /// - Return: 添加元素后当前元素的箭头所指的位置
    ///
    func linkEndAnimationTarget() -> CGPoint? {
        if index == 0 {
            // 第一个元素没有尾部
            return nil
        }
        // 就是正数 1...count
        let newIndex = context.list.count - index + 1
        return context.position[newIndex]
    }
}

extension ListNodeContext: Identifiable {
    public var id: Int {
        index
    }
}
