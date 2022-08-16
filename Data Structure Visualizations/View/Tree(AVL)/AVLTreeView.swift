//
//  AVLTreeView.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/15.
//

import SwiftUI

struct AVLTreeView: View {
    var nodes: BinaryTreeNode {
        let root = BinaryTreeNode(value: 1)
        let left = BinaryTreeNode(parent: root, value: 2)
        root.left = left
        let right = BinaryTreeNode(parent: root, value: 3)
        root.right = right
        let ll = BinaryTreeNode(parent: left, value: 4)
        left.left = ll
        return root
    }
    
    var body: some View {
        ZStack {
            BinaryTreeNodeView(node: nodes)
                .border(.red)
        }
    }
}

struct AVLTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AVLTreeView()
    }
}
