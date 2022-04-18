//
//  ListNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct ListNode: View, Animatable {
    var value: Int? = nil
    var linkEnd: CGPoint? = nil

    var body: some View {
        GeometryReader { g in
            let h = g.size.height
            let w = g.size.width
            let frame = g.frame(in: .named(CoordinateSpaceName.StackLinkedListImplementaion))
            Rectangle()
                .foregroundColor(.cyan)
                .overlay(content: {
                    ValueNode(value: value ?? 0, isBlack: value == nil)
                })
                .frame(width: w * (1 - node_right_rate), height: h)
            Rectangle()
                .foregroundColor(.brown)
                .offset(x: w * (1 - node_right_rate), y: 0)
                .frame(width: w * node_right_rate, height: h)
            if linkEnd != nil {
                LinkArrow(start: CGPoint(x: w * (1 - node_right_rate / 2), y: h / 2), end: CGPoint(x: linkEnd!.x - frame.origin.x - 72, y: linkEnd!.y - frame.origin.y + 16))
                    .stroke(.red, lineWidth: 3.0)
            }
        }
        .frame(width: node_size_width, height: node_size_height)
    }
}

struct ListNode_Previews: PreviewProvider {
    static var previews: some View {
        ListNode(value: 1, linkEnd: CGPoint(x: 100, y: 100))
    }
}
