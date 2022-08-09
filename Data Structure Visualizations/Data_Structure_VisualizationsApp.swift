//
//  Data_Structure_VisualizationsApp.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/14.
//

import SwiftUI

@main
struct Data_Structure_VisualizationsApp: App {
    /// 通过委托来使用生命周期，好像不优雅，但是暂时没有别的方式
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
            // StackArrayImplementation()
            // SampleViewC()
        }
    }
}
