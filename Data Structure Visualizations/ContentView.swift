//
//  ContentView.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = true
    var body: some View {
        NavigationView {
            List {
                NavigationLink( destination: SampleViewC(CGPoint(x:400, y:20), CGPoint(x:20, y:100))
                , isActive: $isActive, label: {
                    Text("测试")
                })
                NavigationLink( destination:
                                    QueueLinkedListImplementation()
                , label: {
                    Text("队列 链表实现")
                })
                NavigationLink(
                    destination: StackLinkedListImplementation().coordinateSpace(name: CoordinateSpaceName.StackLinkedListImplementaion),
                    label: {
                        Text("栈 链表实现")
                    }
                )
                NavigationLink {
                    StackArrayImplementation()
                } label: {
                    Text("栈 数组实现")
                }
            }
        }
                .environmentObject(StackContext())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
