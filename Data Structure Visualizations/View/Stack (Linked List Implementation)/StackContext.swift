//
//  StateContext.swift
//  Data Structure Visualizations
//
//  Created by Wttch on 2022/4/18.
//

import SwiftUI

class StackContext: ObservableObject {

     @Published var list: [ListNodeContext] = []

     @Published var listOffset: [CGSize] = []
     @Published var linkEnd: [CGPoint?] = []

}
