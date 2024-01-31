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
        }
        
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }
        
        return color
    }
}
