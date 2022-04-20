//
// Created by Wttch on 2022/4/19.
//

import Foundation
import SwiftUI

extension CGPoint {

    func distanceTo(_ point: CGPoint) -> Double {
        CGPoint.distance(self, point)
    }

    static func distance(_ point1: CGPoint, _ point2: CGPoint) -> Double {
        hypot(point2.x - point1.x, point2.y - point1.y)
    }

    static func + (_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }

}

extension View {
    ///
    /// 扩展 view 的 frame 函数，使用 CGSize 来控制大小
    ///
    /// - Parameter size: 视图大小
    /// - Returns: 视图自身, 和原生函数一行可以链式调用
    public func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}
