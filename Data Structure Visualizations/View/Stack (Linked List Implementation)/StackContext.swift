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
    private var positionList: [CGPoint] = []
    // 动画偏移数组，每个节点都有一个对应的值，用来动画时偏移使用
    // 考虑不使用偏移，而是直接移动位置，不停的变换位置
    @Published var animationPosition: [CGPoint] = []

    private var columnSize: Int

    init(_ columnSize: Int = 6) {
        self.columnSize = columnSize
        positionList.append(calcNewPosition(0))
    }

    ///
    /// 第 i 的元素的位置在改数组的 list.count - i - 1 的位置
    /// - Parameter index:
    /// - Returns:
    func getPosition(_ index: Int) -> CGPoint {
        return positionList[list.count - index + 1]
    }

    ///
    /// 新增一个数据节点
    ///
    /// - Parameter value: 数据节点的值
    func newNode(_ value: Int) {
        let node = ListNodeContext(value: value, context: self)
        list.append(node)
        positionList.append(calcNewPosition(list.count))
        animationPosition.append(positionList[0])
    }

    ///
    /// 新增一个元素的所在位置
    ///
    /// - Returns: 新增元素的位置
    ///
    private func calcNewPosition(_ index: Int) -> CGPoint {
        if index == 0 {
            return CGPoint(x: new_list_node_center_x
                    + node_size_width * node_right_rate / 2, y: new_value_node_offset_y)
        }
        let newIndex = index - 1
        return CGPoint(x: CGFloat(newIndex % 6) * 100.0 + 100, y: CGFloat(newIndex / 6) * 80 + 240)
    }

    ///
    /// 入栈时的移动和画线的动画
    ///
    func enterMoveAnimation() {
        list.forEach { ctx in
            animationPosition[ctx.index] = getPosition(ctx.index + 1)
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
    /// 获取当前元素的位置
    ///
    /// - Returns: 当前元素位置
    ///
    func position() -> CGPoint {
        // 就是正数 0...count - 1
        return context.animationPosition[context.list.count - index - 1]
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
