//
//  StackArrayImplementation.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/4.
//

import SwiftUI

struct StackArrayImplementation: View {
    var body: some View {
        VStack {
            HStack {
                Button("入栈", action: {})
                Button("出栈", action: {})
                Button("清空", action: {})
                Spacer()
            }
            .padding(.leading, 10)
            .frame(maxHeight: 40)
            .background(.gray.opacity(0.2))
            StackArrayNode(index: 1)
                .position(x:1 ,y: 1)
            VStack {
                ForEach(0..<3) { row in
                    HStack(spacing:0) {
                        ForEach(0..<15, content: { index in
                            StackArrayNode(index: row * 15 + index)
                        })
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }
}

struct StackArrayImplementation_Previews: PreviewProvider {
    static var previews: some View {
        StackArrayImplementation()
    }
}
