//
//  BinaryTreeNodePositionModifier.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/15.
//

import SwiftUI


struct BinaryTreeNodePositionModifier: ViewModifier {
    private let node: BinaryTreeNode
    
    init(node: BinaryTreeNode) {
        self.node = node
    }
    
    func body(content: Content) -> some View {
        let width: CGFloat = 800
        let center: CGFloat = width / 2
        let rIndex: CGFloat = CGFloat(node.index) / 2 * 3 - CGFloat(node.index)
        print(node.deep, node.index, rIndex)
        print(CGFloat(node.index) * 100, CGFloat(node.deep - 1) * 100 + 200)
        return content
            .frame(width: 40, height: 40)
            .position(x: CGFloat(node.index) * 50, y: CGFloat(node.deep - 1) * 20 + 200 )
    }
}
