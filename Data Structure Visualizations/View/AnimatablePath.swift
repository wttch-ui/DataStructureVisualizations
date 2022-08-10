//
//  AnimatablePath.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/9.
//

import SwiftUI

struct TestView: View {
    @State var rate: CGFloat = 0
    var body: some View {
        ZStack {
            AnimatablePath(
                p1: CGPoint(x: 400, y: 100),
                p2: CGPoint(x: 500, y: 100),
                p3: CGPoint(x: 200, y: 200),
                rate: self.rate)
                        
                .stroke(.green, lineWidth: 2)
                .frame(width: 800, height: 600)
                .border(.red)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
                        self.rate = 100
                    }
                }
        }
    }
}

///
/// 一个可移动的路径
///
/// 三个点, 从前两个点的路径变换到后两个点的路径, 并且路径要使用 PathAnimationHelper 里面的折线
///
/// 假设 A - B ---> B - C, 动画时只需路线开始点 S 从 A 点到 B 点, 路线结束点 E 从 B 点到 C 点, 途中需要计算 S, E 的位置即可
///
struct AnimatablePath: Shape {
    private var p1: CGPoint
    private var p2: CGPoint
    private var p3: CGPoint
    private var pathAnimationHelper1: PathAnimationHelper
    private var pathAnimationHelper2: PathAnimationHelper
    private var usePath: Bool
    var rate: CGFloat
    
    var animatableData: CGFloat {
        get { rate }
        set { rate = newValue }
    }
    
    init(p1: CGPoint, p2: CGPoint, p3: CGPoint, rate: CGFloat, usePath: Bool = true) {
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        // 暂未考虑节点的位置
        // 如果考虑节点的位置
        self.pathAnimationHelper1 = PathAnimationHelper.create(p1, p2, usePath: usePath)
        self.pathAnimationHelper2 = PathAnimationHelper.create(p2, p3, usePath: usePath)
        self.rate = rate
        self.usePath = usePath
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let remainPoints = pathAnimationHelper1.remainPoints(self.rate)
            let travelPoints = pathAnimationHelper2.traveledPoints(self.rate)
            if usePath {
                path.move(to: remainPoints[0])
                for i in 1..<remainPoints.count {
                    path.addLine(to: remainPoints[i])
                }
                path.move(to: travelPoints[0])
                for i in 1..<travelPoints.count {
                    path.addLine(to: travelPoints[i])
                }
            } else {
                path.move(to: remainPoints[0])
                path.addLine(to: travelPoints.last!)
            }
        }
    }
}

struct AnimatablePath_Previews: PreviewProvider {
    struct WrapperView : View {
        @State var rate: CGFloat = 0
        var body: some View {
            AnimatablePath(p1: CGPoint(x: 400, y: 100), p2: CGPoint(x: 500, y: 100), p3: CGPoint(x: 200, y: 100), rate: self.rate)
                .stroke(.green, lineWidth: 2)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
                        self.rate = 100
                    }
                }
                .border(.red)
        }
    }
    static var previews: some View {
        WrapperView()
    }
}
