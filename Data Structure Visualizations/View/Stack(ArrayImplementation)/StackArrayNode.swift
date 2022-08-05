//
//  StackArrayNode.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/4.
//

import SwiftUI

struct StackArrayNode: View {
    let nodeSize = 48.0
    
    var index: Int
    var body: some View {
        VStack {
            Text("")
                .frame(width: nodeSize, height: nodeSize)
                .border(.red)
            Text("\(index)")
                .foregroundColor(.blue)
                .frame(width: nodeSize, height: nodeSize / 3, alignment: .center)
        }
    }
}

struct StackArrayNode_Previews: PreviewProvider {
    static var previews: some View {
        StackArrayNode(index: 0)
    }
}
