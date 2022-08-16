//
//  BinaryTreeNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/15.
//

import Foundation


class BinaryTreeNode {
    static var maxDeep: Int = 1
    static var showDetail = true
    
    
    var parent: BinaryTreeNode?
    var value: Int
    private var _left: BinaryTreeNode?
    private var _right: BinaryTreeNode?
    
    var left: BinaryTreeNode? {
        get { _left }
        set {
            _left = newValue
            _left?.index = self.index * 2
        }
    }
    var right: BinaryTreeNode? {
        get { _right }
        set {
            _right = newValue
            _right?.index = self.index * 2 + 1
        }
    }
    
    var deep: Int = 1
    var index: Int = 1
    
    init(parent: BinaryTreeNode? = nil, value: Int) {
        self.parent = parent
        self.value = value
        self.deep = (parent?.deep ?? 0) + 1
        BinaryTreeNode.maxDeep = max(BinaryTreeNode.maxDeep, self.deep)
    }
}
