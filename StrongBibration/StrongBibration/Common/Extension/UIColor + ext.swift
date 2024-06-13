//
//  UIColor + ext.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import Foundation
import UIKit

extension UIColor {
    enum ColorType {
        case white
        case lightPink
        case darkPink
        case tabBarPink
        case darkGradientPink
        case lightGradientPink
        case patternPink
        case purple
    }
    
    static func theme(_ colorType: ColorType) -> UIColor {
        var color: UIColor?
        
        switch colorType {
        case .white:
            color = UIColor(named: "white")
        case .lightPink:
            color = UIColor(named: "lightPink")
        case .darkPink:
            color = UIColor(named: "darkPink")
        case .tabBarPink:
            color = UIColor(named: "tabBarPink")
        case .darkGradientPink:
            color = UIColor(named: "darkGradientPink")
        case .lightGradientPink:
            color = UIColor(named: "lightGradientPink")
        case .patternPink:
            color = UIColor(named: "patternPink")
        case .purple:
            color = UIColor(named: "purple")
        }
        
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }
        
        return color
    }
}
