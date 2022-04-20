//
//  ListNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

///
/// 节点
///
struct ListNode: View, Animatable {
    // 右侧指针视图所占的宽度比例
    let pointerWidthRate = 1.0 / 4
    // 节点的数据值
    var value: Int?

    var context: ListNodeContext?

    // 过去实际的元素的值
    var realValue: Int? {
        context?.value ?? value
    }

    // 判断下一个节点是否有数据
    var isNextNull: Bool {
        if context != nil {
            return context!.nextNode()?.value == nil
        }
        return value == nil
    }

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            Rectangle()
                    .foregroundColor(.cyan)
                    .overlay(content: {
                        ValueNode(value: realValue ?? 0, isBlack: realValue == nil)
                    })
                    .frame(width: width * (1 - pointerWidthRate), height: height)
            PointerView(isNull: isNextNull)
                    .offset(x: width * (1 - pointerWidthRate), y: 0)
                    .frame(width: width * pointerWidthRate, height: height)
        }
                .frame(width: node_size_width, height: node_size_height)
    }
}

struct ListNode_Previews: PreviewProvider {
    static var previews: some View {
        ListNode(value: 1)
    }
}
