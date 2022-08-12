//
//  AnimationSpeedPicker.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/8/12.
//

import SwiftUI

///
/// 动画速度
///
fileprivate enum Speed: String, CaseIterable {
    case verySlow
    case slow
    case normal
    case fast
    case veryFast
    
    var info: (key: String, title: String, speed: Double) {
        switch (self) {
        case .verySlow: return (rawValue, "非常慢", 4)
        case .slow: return (rawValue, "慢", 2)
        case .normal: return (rawValue, "正常", 1)
        case .fast: return (rawValue, "快", 0.5)
        case .veryFast: return (rawValue, "非常快", 0.2)
        }
    }
}

///
/// 动画速度选择器
///
struct AnimationSpeedPicker: View {
    // 绑定的动画速度的值
    @Binding var duration: Double
    var body: some View {
        Picker("动画速度", selection: $duration) {
            ForEach(Speed.allCases, id: \.rawValue) { speed in
                Text(speed.info.title).tag(speed.info.speed)
            }
        }
        .frame(width: 320)
        .pickerStyle(SegmentedPickerStyle())
    }
}
