//
//  AnimatablePath.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/9.
//

import SwiftUI


///
/// 折线路径
///
struct AnimatablePath: Shape {
    private var p1: CGPoint
    private var p2: CGPoint
    @State private var pathAnimationHelper1: PathAnimationHelper
    private var usePath: Bool
    
    
    init(p1: CGPoint, p2: CGPoint, usePath: Bool = true) {
        self.p1 = p1
        self.p2 = p2
       
        self.pathAnimationHelper1 = PathAnimationHelper.create(p1, p2, usePath: usePath)
        self.usePath = usePath
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let remainPoints = pathAnimationHelper1.remainPoints(1)
            if usePath {
                path.move(to: remainPoints[0])
                for i in 1..<remainPoints.count {
                    path.addLine(to: remainPoints[i])
                }
            } else {
                path.move(to: remainPoints[0])
                path.addLine(to: remainPoints.last!)
            }
        }
    }
}
