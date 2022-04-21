//
//  StackLinkedListImplementaion.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct StackLinkedListImplementation: View {
    // 展示新值
    @State private var newValueShow = false
    // 新值偏移
    @State private var newValueOffsetY = 0.0
    // 新值
    @State private var newValue = 0

    @State private var newNodeValue: Int? = nil

    @State private var topLinkEnd = CGPoint(x: new_list_node_center_x
            + node_size_width * node_right_rate / 2, y: new_value_node_offset_y)

    @EnvironmentObject var context: StackContext

    var body: some View {
        GeometryReader { _ in
            Button("新增") {
                newValue = Int(arc4random_uniform(10))

                newValueShow = true
                newNodeValue = newValue
                // 新增
                withAnimation(.easeInOut(duration: 1)) {
                    newValueOffsetY = new_value_node_offset_y
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        topLinkEnd = CGPoint(x: new_list_node_center_x
                                + node_size_width * node_right_rate / 2, y: new_value_node_offset_y)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    newValueOffsetY = 0
                    newValueShow = false
                    context.newNode(newValue)
                    withAnimation(.linear(duration: 1)) {
                        context.enterMoveAnimation()
                        topLinkEnd = context.animationPosition[context.animationPosition.count - 1]
                    }
                })
            }
                    .position(x: 40, y: 0)
            if newValueShow {
                Text("新值：")
                        .position(x: 160, y: 0)
                ValueNode(value: newValue, isBlack: false)
                        .position(newValuePos())
                        .offset(x: 0, y: newValueOffsetY)
                        .zIndex(10)
            }
            PointerView(isNull: context.list.count == 0, text: "Top")
                    .position(x: 32, y: new_value_node_offset_y)
                    .frame(width: 24, height: 24)
            if context.animationPosition.count >= 1 {
                LinkArrow(
                        start: CGPoint(x: 32 + 16, y: new_value_node_offset_y),
                        end: topLinkEnd + CGPoint(x: -24, y: 0)
                ).stroke(.red, lineWidth: 3.0)
                        .zIndex(10)
            }
            // ListNode(value: newNodeValue)
            //        .position(newNodePos())
            ForEach(context.list) { ctx in
                // 不然会报一个 状态 nil 的错误
                ListNode(context: ctx)
                        .position(context.animationPosition[ctx.index])
                let linkEndIndex = ctx.index - 1
                if linkEndIndex >= 0 {
                    LinkArrow(
                            start: context.animationPosition[ctx.index] + CGPoint(x: 24, y: 0),
                            end: context.animationPosition[linkEndIndex] + CGPoint(x: -24, y: 0)
                    ).stroke(.red, lineWidth: 3.0)
                            .zIndex(10)
                }
            }
        }
                .offset(y: 16)
    }

    func newValuePos() -> CGPoint {
        return CGPoint(x: new_list_node_center_x, y: 0)
    }

    func newNodePos() -> CGPoint {
        return CGPoint(x: new_list_node_center_x
                + node_size_width * node_right_rate / 2, y: new_value_node_offset_y)
    }
}

struct StackLinkedListImplementation_Previews: PreviewProvider {
    static var previews: some View {
        StackLinkedListImplementation()
    }
}
