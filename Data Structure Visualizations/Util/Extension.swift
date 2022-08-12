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

extension Double {
    ///
    /// 执行动画, 使用时间为 self
    /// - Parameter content: 动画执行的内容
    ///
    public func animation(_ content: () -> ())  {
        withAnimation(.easeInOut(duration: self)) {
            content()
        }
    }
    
    
    ///
    /// 延迟 self 秒后执行给定的闭包
    /// - Parameter content: 要延迟执行的闭包
    ///
    public func asyncAfter(_ content: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + self) {
            content()
        }
    }
    
    ///
    /// 延迟执行动画,  动画时间为 self, 延迟时间为 delay
    /// - Parameters:
    ///   - delay: 延迟时间
    ///   - content: 动画执行的闭包
    ///   
    public func animationAfter(_ delay: Double, _ content: @escaping () -> ()) {
        delay.asyncAfter {
            self.animation(content)
        }
    }
}
