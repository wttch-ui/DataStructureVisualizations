//
//  PathAnimation.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/5.
//

import SwiftUI


///
/// 路径动画帮助类
///
struct PathAnimationHelper {
    // 点集合
    var points: [CGPoint]
    // 点点间距离, 比 points 个数小 1
    private var distances: [CGFloat] = []
    // 总长度, 按点集顺序统计的长度之和
    private var totalLength: CGFloat = 0
    
    ///
    /// 使用点集合初始化路径
    /// 要保证点数量至少为 2
    ///
    /// - Parameter points: 路径点集
    ///
    init(points: [CGPoint]) {
        assert(points.count >= 2)
        self.points = points
        var start = points[0]
        // 计算点与点之间的距离和距离总和
        for i in 1..<points.count {
            let distance = points[i].distanceTo(start)
            distances.append(distance)
            totalLength += distance
            start = points[i]
        }
    }
    
    ///
    /// 获取走过的路径段数和实时位置. 返回值为元组: 第一个值为走过的路径段数, 第二个值为实时位置
    ///
    /// - Parameter rate: 走过的路径所占总长度的比例
    /// - Returns: 走过的路径段数和实时位置
    ///
    private func curPosAndIndex(_ rate: CGFloat) -> (Int, CGPoint) {
        // 当前长度
        var curLen = rate / 100 * totalLength
        // 已经走过的完整线段数量
        var t = 0
        for (i, len) in distances.enumerated() {
            if curLen - len > 0 {
                curLen -= len
                continue
            } else {
                t = i
                break
            }
        }
        // 当前段走过的比例
        let lastRate = curLen / distances[t]
        // 当前段的 dx, dy
        let dx = points[t + 1].x - points[t].x
        let dy = points[t + 1].y - points[t].y
        // 计算当前位置
        let curPos = CGPoint(x: points[t].x + dx * lastRate, y: points[t].y + dy * lastRate)
        return (t, curPos)
    }
    
    
    ///
    /// 获取实时位置
    ///
    /// - Parameter rate: 走过的路径占总路径的比例
    /// - Returns: 实时位置
    ///
    func curPos(_ rate: CGFloat) -> CGPoint {
        let (_, curPos) = curPosAndIndex(rate)
        return curPos
    }
    
    
    ///
    /// 获取已经走过的路径点, 包含已经走过的点和当前所在位置
    ///
    /// - Parameter rate: 指定位置在总路程中的比例
    /// - Returns: 已经走过的路径点, 包含已经走过的点和当前所在位置
    ///
    func traveledPoints(_ rate: CGFloat) -> [CGPoint] {
        var res: [CGPoint] = []
        let (idx, pos) = curPosAndIndex(rate)
        for i in 0...idx {
            // 走过的路径点
            res.append(points[i])
        }
        // 当前位置
        res.append(pos)
        return res
    }
    
    
    
    ///
    /// 获取剩余的路径点, 包含当前所在位置和未走过的路径点
    ///
    /// - Parameter rate: 指定位置在总路程中的比例
    /// - Returns: 剩余的路径点, 包含当前所在位置和未走过的路径点
    ///
    func remainPoints(_ rate: CGFloat) -> [CGPoint] {
        var res: [CGPoint] = []
        let (idx, pos) = curPosAndIndex(rate)
        // 当前位置
        res.append(pos)
        if idx + 1 < points.count {
            // 未走过的路径点
            for i in idx+1..<points.count {
                res.append(points[i])
            }
        }
        return res
    }
}



///
/// 沿路径点变换位置的动画
///
struct PathPositionAnimatableModifier : AnimatableModifier {
    // 路径帮助类
    private var pathAnimationHelper: PathAnimationHelper
    // 当前位置占总路径的比例
    var rate: CGFloat = 0
    // 当前位置
    var curPos: CGPoint
    
    ///
    /// 构造位置路径动画
    /// 可以根据配置自动生成简单折线,
    ///
    /// - Parameters:
    ///   - p1: 开始位置
    ///   - p2: 结束位置
    ///   - rate: 当前位置所占总路径的比例
    ///   - offset: 折线向两边偏移的量
    ///   - usePath: 是否使用自动生成的折线
    ///
    init(_ p1: CGPoint, _ p2: CGPoint, rate: CGFloat = 0, usePath: Bool = true, offset: CGFloat = 40) {
        var nodes: [CGPoint]
        if p1.y == p2.y || !usePath {
            // 如果在一行, 或者不使用折线
            nodes = [p1, p2]
        } else {
            let dy = (p2.y - p1.y) / 2
            nodes = [p1,
                     CGPoint(x: p1.x + offset, y: p1.y),
                     CGPoint(x: p1.x + offset, y: p1.y + dy),
                     CGPoint(x: p2.x - offset, y: p2.y - dy),
                     CGPoint(x: p2.x - offset, y: p2.y),
                     p2]
        }
        self.pathAnimationHelper = PathAnimationHelper(points: nodes)
        self.rate = rate
        self.curPos = p1
    }
    
    // 动画使用的值
    var animatableData: CGFloat {
        get { rate }
        set {
            rate = newValue
            // 重新计算位置
            curPos = self.pathAnimationHelper.curPos(rate)
        }
    }
    
    
    // 为 view 设置位置
    func body(content: Content) -> some View {
        content.position(
            curPos
        )
    }
    
}

