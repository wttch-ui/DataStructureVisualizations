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

    @State var list: [ListNodeContext] = []

    @State var listOffset: [CGSize] = []
    @State var linkEnd: [CGPoint?] = []

    @EnvironmentObject var context: StackContext

    var body: some View {
        GeometryReader { g in
            Button("新增") {
                newValue = Int(arc4random_uniform(10))

                newValueShow = true
                withAnimation(.easeInOut(duration: 1)) {
                    newValueOffsetY = new_value_node_offset_y
                    context.enterMoveAnimation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    newValueOffsetY = 0
                    newValueShow = false
                    // 新增
                    context.newNode(newValue)
                    for i in 0..<context.listOffset.count {
                        context.listOffset[i] = CGSize.zero
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
            Circle()
                    .foregroundColor(.red)
                    .overlay(content: {
                        Text("栈顶")
                                .font(.caption)
                                .foregroundColor(.primary)
                    })
                    .position(x: 32, y: new_value_node_offset_y)
                    .frame(width: 24, height: 24)
            ListNode()
                    .position(newNodePos())
            ForEach(context.list) { ctx in
                ListNode(value: ctx.value, linkEnd: context.linkEnd[ctx.index])
                        .position(ctx.position())
                        .offset(context.listOffset[ctx.index])
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
