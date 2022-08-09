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
    
    
    init(points: [CGPoint]) {
        self.points = points
        var start = points[0]
        for i in 1..<points.count {
            let distance = points[i].distanceTo(start)
            distances.append(distance)
            totalLength += distance
            start = points[i]
        }
    }
    
    func traveledPoints(_ rate: CGFloat) -> [CGPoint] {
        var res: [CGPoint] = []
        let (idx, pos) = curPosAndIndex(rate)
        for i in 0...idx {
            res.append(points[i])
        }
        res.append(pos)
        return res
    }
    
    func curPos(_ rate: CGFloat) -> CGPoint {
        let (_, curPos) = curPosAndIndex(rate)
        return curPos
    }
    
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
    
    func remainPoints(_ rate: CGFloat) -> [CGPoint] {
        var res: [CGPoint] = []
        let (idx, pos) = curPosAndIndex(rate)
        res.append(pos)
        if idx + 1 < points.count {
            for i in idx+1..<points.count {
                res.append(points[i])
            }
        }
        return res
    }
}



struct PathAnimatableModifier : AnimatableModifier {
    var pathAnimationHelper: PathAnimationHelper
    
    var rate: CGFloat = 0
    
    var curPos: CGPoint
    
    init(_ p1: CGPoint, _ p2: CGPoint, rate: CGFloat = 0, usePath: Bool = true) {
        var nodes: [CGPoint]
        if p1.y == p2.y || !usePath {
            nodes = [p1, p2]
        } else {
            let o1: CGFloat = 40
            let dy = (p2.y - p1.y) / 2
            nodes = [p1,
                     CGPoint(x: p1.x + o1, y: p1.y),
                     CGPoint(x: p1.x + o1, y: p1.y + dy),
                     CGPoint(x: p2.x - o1, y: p2.y - dy),
                     CGPoint(x: p2.x - o1, y: p2.y),
                     p2]
        }
        self.pathAnimationHelper = PathAnimationHelper(points: nodes)
        self.rate = rate
        self.curPos = p1
    }
    
    
    var animatableData: CGFloat {
        get {rate}
        set {
            rate = newValue
            curPos = self.pathAnimationHelper.curPos(rate)
        }
    }
    
    
    func body(content: Content) -> some View {
        content.position(
            curPos
        )
    }
    
    
}

