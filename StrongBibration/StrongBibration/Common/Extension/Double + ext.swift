//
//  Double + ext.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
