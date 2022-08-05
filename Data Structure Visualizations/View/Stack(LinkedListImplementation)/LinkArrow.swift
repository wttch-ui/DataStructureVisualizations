//
//  LinkArrow.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

struct LinkArrow: Shape {
    var start: CGPoint
    var end: CGPoint

    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get {
            AnimatablePair(start.animatableData, end.animatableData)
        }
        set {
            start = newValue.first.point
            end = newValue.second.point
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        path.closeSubpath()
        return path
    }
}

extension CGPoint.AnimatableData {
    var point: CGPoint {
        CGPoint(x: first, y: second)
    }
}
