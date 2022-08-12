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
    var positionCalculator: PositionCalculator

    @Published var topLinkEnd: CGPoint

    // 新值偏移
    @Published var newValueOffsetY = 0.0
    // 新值
    @Published var newValue: Int?

    private var columnSize: Int
    @Published
    var posModiftor: [PathPositionAnimatableModifier] = []
    @Published
    var rate: CGFloat = 0
    @Published
    var duration: Double = 1.0
    
    @Published
    var changing: Bool = false
    
    init(_ columnSize: Int = 10) {
        self.columnSize = columnSize
        positionCalculator = PositionCalculator(columnSize)
        topLinkEnd = positionCalculator[0]
    }
    
    ///
    /// 第 i 的元素的位置在改数组的 list.count - i - 1 的位置
    /// - Parameter index:
    /// - Returns:
    func getPositionByStackIndex(_ index: Int) -> CGPoint {
        positionCalculator[list.count - index + 1]
    }

    func onNewNodeClick(_ value: Int? = nil) {
        changing(duration * 2)
        let newValue = value ?? Int(arc4random_uniform(10))
        self.newValue = newValue
        // 新增
        duration.animation {
            newValueOffsetY = new_value_node_offset_y
        }

        (duration / 2).animationAfter(duration / 2, topLinkReset)
        
        duration.asyncAfter {
            self.newValueOffsetY = 0
            self.newValue = nil
            
            let node = ListNodeContext(value: newValue, context: self)
            self.list.append(node)
            self.posModiftor.append(PathPositionAnimatableModifier(self.positionCalculator[0], self.positionCalculator[1], self.positionCalculator[2],
                                                             rate: 0, ctx: node, start: CGPoint(x: 50, y: 50)))
            self.pushAnimation()
        }
    }
    
    func changing(_ seconds: Double) {
        changing = true
        seconds.asyncAfter {
            self.changing = false
        }
    }
    
    func removeNode() {
        posModiftor.removeLast()
        list.removeLast()
    }

    ///
    /// 入栈时的移动和画线的动画
    ///
    func pushAnimation() {
        self.rate = 0
        duration.animation {
            self.rate = 100
        }
        list.forEach { ctx in
            posModiftor[ctx.index] = PathPositionAnimatableModifier(
                getPositionByStackIndex(ctx.index+2),
                getPositionByStackIndex(ctx.index+1),
                getPositionByStackIndex(ctx.index),
                rate: 0,
                
                ctx: ctx,
                start: CGPoint(x: 50, y: 50),
                usePath: ctx.index != list.count - 1)
            withAnimation(.easeInOut(duration: duration)) {
                posModiftor[ctx.index].rate = 100
            }
        }
        duration.animation(topLink)
    }
    
    ///
    /// 入栈时的移动和画线的动画
    ///
    func popAnimation() {
        list.forEach { ctx in
            posModiftor[ctx.index].rate = 100
            withAnimation(.easeInOut(duration: duration)) {
                posModiftor[ctx.index] = PathPositionAnimatableModifier(
                    getPositionByStackIndex(ctx.index+2),
                    getPositionByStackIndex(ctx.index+1),
                    getPositionByStackIndex(ctx.index),
                    rate: 0,
                    ctx: ctx,
                    start: CGPoint(x: 50, y: 50),
                    usePath: ctx.index != list.count - 1)
            }
        }
        duration.animation(self.topLinkReset)
    }

    func onPop() {
        popAnimation()
        duration.asyncAfter {
            (self.duration / 2).animation(self.topLink)
            self.removeNode()
        }
    }
    
    private func topLinkReset() {
        topLinkEnd = self.positionCalculator[0]
    }
    
    private func topLink() {
        topLinkEnd = self.positionCalculator[1]
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

    var context: StackContext = StackContext()

    init(value: Int, context: StackContext) {
        self.value = value
        self.context = context
        index = context.list.count
    }

    init(value: Int, index: Int) {
        self.value = value
        self.index = index
    }

    ///
    /// 获取栈的下一个元素
    /// - Returns:
    func nextNode() -> ListNodeContext? {
        if index - 1 < 0 {
            return nil
        }
        return context.list[index - 1]
    }
}

extension ListNodeContext: Identifiable {
    public var id: Int {
        index
    }
}
