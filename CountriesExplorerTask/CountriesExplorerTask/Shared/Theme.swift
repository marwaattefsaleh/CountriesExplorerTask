//
//  Theme.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation
import UIKit

struct Theme {
    struct Colors {
        static let colorFFFFFF = "#FFFFFF"
        static let color000000 = "#000000"
        static let colorDDDDDD = "#DDDDDD"
        static let color8E8E93 = "#8E8E93"
        static let colorEceef2 = "#eceef2"
        static let colorF9fafb = "#f9fafb"
    }
    
    struct Sizes {
        static let pt1: CGFloat = getDimen(size: 1.0)
        static let pt2: CGFloat = getDimen(size: 2.0)
        static let pt4: CGFloat = getDimen(size: 4.0)
        static let pt6: CGFloat = getDimen(size: 6.0)
        static let pt7: CGFloat = getDimen(size: 7.0)
        static let pt8: CGFloat = getDimen(size: 8.0)
        static let pt10: CGFloat = getDimen(size: 10.0)
        static let pt12: CGFloat = getDimen(size: 12.0)
        static let pt14: CGFloat = getDimen(size: 14.0)
        static let pt16: CGFloat = getDimen(size: 16.0)
        static let pt20: CGFloat = getDimen(size: 20.0)
        static let pt22: CGFloat = getDimen(size: 22.0)
        static let pt25: CGFloat = getDimen(size: 25.0)
        static let pt30: CGFloat = getDimen(size: 30.0)
        static let pt35: CGFloat = getDimen(size: 35.0)
        static let pt45: CGFloat = getDimen(size: 45.0)
        static let pt46: CGFloat = getDimen(size: 46.0)
        static let pt50: CGFloat = getDimen(size: 50.0)
        static let pt60: CGFloat = getDimen(size: 60.0)
        static let pt80: CGFloat = getDimen(size: 80.0)
        static let pt100: CGFloat = getDimen(size: 100.0)
        static let pt120: CGFloat = getDimen(size: 120.0)
        static let pt152: CGFloat = getDimen(size: 152.0)
        static let pt154: CGFloat = getDimen(size: 154.0)
        static let pt185: CGFloat = getDimen(size: 185.0)
        static let pt285: CGFloat = getDimen(size: 285.0)
    }
    
    static func getDimen(size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return size * 1.2
        } else {
            return size
        }
    }
}
