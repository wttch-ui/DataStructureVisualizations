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
                NavigationLink(
                    destination: StackLinkedListImplementation().coordinateSpace(name: CoordinateSpaceName.StackLinkedListImplementaion),
                    isActive: $isActive,
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
