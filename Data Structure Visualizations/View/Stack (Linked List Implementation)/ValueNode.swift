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
    let colors: [Color] = [
        .red, .green, .pink, .purple, .indigo, .mint, .secondary, .teal
    ]

    var body: some View {

        Circle()
            .foregroundColor(isBlack ? .white : colors[value % colors.count])
            .overlay(content: {
                if !isBlack {
                    Text("\(value)")
                        .font(.title)
                        .foregroundColor(.black)
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
