//
//  BinaryTreeNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/15.
//

import SwiftUI


struct BinaryTreeNodeView: View {
    private let node: BinaryTreeNode
    
    init(node: BinaryTreeNode) {
        self.node = node
    }
    
    // MARK: 属性计算
    private var detailInfoHeight: CGFloat {
        return BinaryTreeNode.showDetail ? 12 : 0
    }
    
    // MARK: 子视图
    private func nodeValueView(_ geo: GeometryProxy) -> some View {
        let rHeight = (geo.size.height - detailInfoHeight) * 4 / 4
        let size = min(geo.size.width, rHeight) / 3 * 2
        return Rectangle()
            .fill(.cyan)
            .overlay(content: {
                Circle()
                    .fill()
                    .overlay(content: {
                        Text("\(node.value)")
                            .foregroundColor(.black)
                    })
                    .frame(width: size, height: size)
            })
            .frame(width: geo.size.width, height: rHeight)
    }
    
    private var detailInfoView: some View {
        return HStack(spacing: 0) {
            Text("d:\(node.deep)")
            Spacer()
            Text("i:\(node.index)")
        }
        .foregroundColor(.black)
        .font(.custom("", size: 11))
        .frame(height: detailInfoHeight)
        .background(.green)
    }
    
    private func pointerView(_ geo: GeometryProxy) -> some View {
        return HStack(spacing: 1.0) {
            PointerView(isNull: node.left == nil)
            PointerView(isNull: node.right == nil)
        }
        .frame(width: geo.size.width, height:
                (geo.size.height - detailInfoHeight) / 5)
    }
    
    @ViewBuilder
    var getBody: some View {
        GeometryReader { g in
            GeometryReader { geo in
                VStack(spacing: 1.0) {
                    nodeValueView(geo)
                    
                    detailInfoView
                    
                    pointerView(geo)
                }
            }
            .frame(width: 48, height: 64)
            
            if let left = node.left {
                BinaryTreeNodeView(node: left)
                    .border(.blue)
            }
            if let right = node.right {
                BinaryTreeNodeView(node: right)
                    .border(.green)
            }
        }
    }
    
    // MARK: body
    var body: some View {
        getBody
            .modifier(BinaryTreeNodePositionModifier(node: node))
    }
}

struct BinaryTreeNode_Previews: PreviewProvider {
    static var nodes: BinaryTreeNode {
        let root = BinaryTreeNode(value: 1)
        let left = BinaryTreeNode(parent: root, value: 2)
        root.left = left
        let right = BinaryTreeNode(parent: root, value: 3)
        root.right = right
        let ll = BinaryTreeNode(parent: left, value: 4)
        left.left = ll
        return root
    }
    
    static var previews: some View {
        BinaryTreeNodeView(node: nodes)
            .offset(CGSize(width: 0, height: -280))
            .frame(width: 1000, height: 600)
    }
}
