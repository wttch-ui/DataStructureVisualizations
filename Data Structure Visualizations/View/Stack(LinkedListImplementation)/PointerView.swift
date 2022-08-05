//
// Created by Wttch on 2022/4/19.
//

import SwiftUI

///
/// 指针视图，以后指针视图都尽量整合到这里来，做成通用的指针
///
struct PointerView: View {
    // 是否为空
    var isNull = true
    // 显示的文字
    var text: String = ""

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                    .foregroundColor(isNull ? .purple : .brown)
                    .frame(geometry.size)
                    .overlay(content: {
                        Text(text)
                                .font(.subheadline.bold())
                    })
        }
    }
}

struct PointerView_Previews: PreviewProvider {
    static var previews: some View {
        PointerView()
    }
}
