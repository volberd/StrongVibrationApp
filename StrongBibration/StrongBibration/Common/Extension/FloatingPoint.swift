//
//  FloatingPoint.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
