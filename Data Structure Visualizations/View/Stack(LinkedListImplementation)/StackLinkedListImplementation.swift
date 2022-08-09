//
//  StackLinkedListImplementaion.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct StackLinkedListImplementation: View {
    @EnvironmentObject var context: StackContext

    var body: some View {
        GeometryReader { _ in
            Button("新增") {
                context.newValue = Int(arc4random_uniform(10))
                // 新增
                withAnimation(.easeInOut(duration: 1)) {
                    context.newValueOffsetY = new_value_node_offset_y
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        context.topLinkEnd = context.getPosition(0)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    context.newValueOffsetY = 0
                    context.newNode(context.newValue!)
                    context.newValue = nil
                    context.pushAnimation()
                    
                })
            }
                    .position(x: 40, y: 0)
            if !context.list.isEmpty {
                Button("出栈") {
                    context.onPop()
                }
                        .position(x: 40, y: 60)
            }
            if context.newValue != nil {
                Text("新值：")
                        .position(x: 160, y: 0)
                ValueNode(value: context.newValue!, isBlack: false)
                        .position(newValuePos())
                        .offset(x: 0, y: context.newValueOffsetY)
                        .zIndex(10)
            }
            PointerView(isNull: context.list.count == 0, text: "Top")
                    .position(x: 32, y: new_value_node_offset_y)
                    .frame(width: 24, height: 24)
            if context.animationPosition.count >= 1 {
                LinkArrow(
                        start: CGPoint(x: 32 + 16, y: new_value_node_offset_y),
                        end: context.topLinkEnd + CGPoint(x: -24, y: 0)
                ).stroke(.red, lineWidth: 3.0)
                        .zIndex(10)
            }
            // ListNode(value: newNodeValue)
            //        .position(newNodePos())
            ForEach(context.list) { ctx in
                // 不然会报一个 状态 nil 的错误
                ListNode(context: ctx)
                    .modifier(context.posModiftor[ctx.index])
                let linkEndIndex = ctx.index - 1
//                if linkEndIndex >= 0 {
//                    LinkArrow(
//                            start: context.animationPosition[ctx.index] + CGPoint(x: 24, y: 0),
//                            end: context.animationPosition[linkEndIndex] + CGPoint(x: -24, y: 0)
//                    ).stroke(.red, lineWidth: 3.0)
//                            .zIndex(10)
//                }
            }
        }
                .offset(y: 16)
    }

    func newValuePos() -> CGPoint {
        CGPoint(x: new_list_node_center_x, y: 0)
    }
}

struct StackLinkedListImplementation_Previews: PreviewProvider {
    static var previews: some View {
        StackLinkedListImplementation()
            .environmentObject(StackContext())
    }
}
