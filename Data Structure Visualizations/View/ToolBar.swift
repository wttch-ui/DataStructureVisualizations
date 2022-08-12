//
//  ToolBar.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/12.
//

import SwiftUI

struct ToolBar<Content: View>: View {
    let content: Content
    
    // @ViewBuilder 闭包
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        .padding(.leading, 10)
        .frame(maxHeight: 40)
        .background(.gray.opacity(0.2))
    }
}

struct ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ToolBar {
            
        }
    }
}
