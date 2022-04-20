//
//  LinkedList.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/15.
//

import Foundation

class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private var length = 0

    func push(_ data: T) {
        let newNode = Node(data)
        if tail == nil {
            tail = newNode
        }
        if head == nil {
            head = newNode
        } else {
            newNode.next = head
            head = newNode
        }
        length += 1
    }

    func pop() -> T? {
        length -= 1
        if head != nil {
            let data = head!.data
            if sg_equateableAnyObject(object1: tail!, object2: head!) {
                head = nil
                tail = nil
                return data
            } else {
                head = head?.next
            }
            return data
        }
        return nil
    }

    func append(_ data: T) {
        let newNode = Node(data)
        if head == nil {
          head = newNode
        }
        if tail == nil {
            tail = newNode
        } else {
            tail!.next = newNode
            tail = tail!.next
        }
        length += 1
    }

}

private class Node<T> {
    var data: T
    var next: Node?
    init(_ data: T) {
        self.data = data
        self.next = nil
    }

    init(_ data: T, next: Node?) {
        self.data = data
        self.next = next
    }
}

// 取出某个对象的地址
func sg_getAnyObjectMemoryAddress(object: AnyObject) -> String {
    let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
    return String(describing: str)
}

// 对比两个对象的地址是否相同
func sg_equateableAnyObject(object1: AnyObject, object2: AnyObject) -> Bool {
    let str1 = sg_getAnyObjectMemoryAddress(object: object1)
    let str2 = sg_getAnyObjectMemoryAddress(object: object2)

    if str1 == str2 {
        return true
    } else {
        return false
    }
}
