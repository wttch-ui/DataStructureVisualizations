//
//  StackLinkedListImplementaion.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct StackLinkedListImplementation: View {
    @EnvironmentObject var context: StackContext
    @State var duration: Double = 1.0
    var body: some View {
        VStack {
            ToolBar {
                Button("新增") { context.onNewNodeClick() }
                    .disabled(context.changing)
                if !context.list.isEmpty {
                    Button("出栈") {
                        context.onPop()
                    }
                    .disabled(context.changing)
                }
                Spacer()
                AnimationSpeedPicker(duration: $context.duration)
            }
            VStack {
                GeometryReader { geo in
                    PointerView(isNull: context.list.count == 0, text: "Top")
                        .position(x: 32, y: new_value_node_offset_y)
                        .frame(width: 24, height: 24)
                    if context.newValue != nil {
                        Text("新值：")
                            .position(x: 160, y: 0)
                        ValueNode(value: context.newValue!, isBlack: false)
                            .position(newValuePos())
                            .offset(x: 0, y: context.newValueOffsetY)
                            .zIndex(10)
                    }
                    if context.list.count >= 1 {
                        LinkArrow(
                            start: CGPoint(x: 32 + 16, y: new_value_node_offset_y),
                            end: context.topLinkEnd + CGPoint(x: -24, y: 0)
                        ).stroke(.red, lineWidth: 3.0)
                            .zIndex(10)
                    }
                    ForEach(context.list) { ctx in
                        // 不然会报一个 状态 nil 的错误
                        ListNode(context: ctx)
                            .modifier(context.posModiftor[ctx.index])
                        
                    }
                }
            }
            .padding(20)
            .border(.red)
        }
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
