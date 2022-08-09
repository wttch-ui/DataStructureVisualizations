//
//  SampleView.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/5.
//

import SwiftUI

struct SampleViewC: View {
    @State var p: CGFloat = 0
    private var p1: CGPoint
    private var p2: CGPoint
    
    init(_ p1: CGPoint, _ p2: CGPoint) {
        self.p1 = p1
        self.p2 = p2
    }
    var body: some View {
        ZStack {
            Text("xxx")
                .modifier(PathAnimatableModifier(p1, p2, rate: self.p))
                .onAppear {
                    withAnimation(.easeInOut(duration: 4).repeatForever()) {
                        self.p = 100
                    }
                }
            
        }
    }
}

struct SampleView: Shape {
    var value: CGFloat
    var nodes: [CGPoint] = [CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 100), CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 40)]
    var animation: PathAnimationHelper
    var r = false
    
    init(_ value: CGFloat = 0, _ r: Bool = false) {
        self.value = value
        self.r = r
        animation = PathAnimationHelper(points: nodes)
    }
    
    var animatableData: CGFloat {
        get { self.value }
        set { self.value = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let points = r ? animation.traveledPoints(self.value) : animation.remainPoints(self.value)
            path.move(to: points[0])
            for i in 1..<points.count {
                path.addLine(to: points[i])
            }
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView(0)
    }
}
