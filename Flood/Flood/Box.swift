//
//  Box.swift
//  Flood
//
//  Created by MAHIMA on 27/08/20.
//  Copyright © 2020 MAHIMA. All rights reserved.
//

import Foundation
import UIKit

enum State {
    case solid
    case broken
    case filled
    func getColor() -> UIColor {
        switch self {
        case .solid: return UIColor.gray
        case .broken: return UIColor.lightGray
        case .filled: return UIColor.blue
        }
    }
}
enum Position {
    case top
    case bottom
    case middle
}
struct Box {
    var val: Int
    var state: State
    var position: Position
}
