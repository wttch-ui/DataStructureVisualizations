//
// Created by Wttch on 2022/4/28.
//

import SwiftUI

///
/// 计算位置
///
/// 第一个位置为 0，是新增的节点的位置，后面的位置按 columnSize 列排开
///
class PositionCalculator {
    // 列数
    let columnSize: Int

    private var cache: [Int: CGPoint] = [Int: CGPoint]()

    init(_ columnSize: Int = 6) {
        self.columnSize = columnSize
    }

    subscript(_ index: Int) -> CGPoint {
        if index < 0 {
            fatalError("位置不能小于 0.")
        }
        if !cache.keys.contains(index) {
            cache[index] = calcPosition(index)
        }
        return cache[index]!
    }

    private func calcPosition(_ index: Int) -> CGPoint {
        if index == 0 {
            return CGPoint(x: new_list_node_center_x
                    + node_size_width * node_right_rate / 2, y: new_value_node_offset_y)
        }
        let newIndex = index - 1
        return CGPoint(x: CGFloat(newIndex % columnSize) * 100.0 + 100, y: CGFloat(newIndex / columnSize) * 80 + 240)
    }
}
