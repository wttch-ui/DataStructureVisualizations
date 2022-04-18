//
//  ValueNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct ValueNode: View {
    var value = 0
    var isBlack = true
    var body: some View {

        Circle()
            .foregroundColor(isBlack ? .white : .orange)
            .overlay(content: {
                if !isBlack {
                    Text("\(value)")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            })
            .frame(width: 24, height: 24)
    }
}

struct ValueNode_Previews: PreviewProvider {
    static var previews: some View {
        ValueNode()
    }
}
