//
//  UIFont + ext.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import UIKit

extension UIFont {
    enum FontType {
        case popSemiBold20
        case popSemiBold22
        case popExtraBold22
        case popExtraBold24
        case popExtraBold32
        case popReg25
        case popReg15
        case popReg13
        case popReg17
        case popSemiBold15
        case popSemiBold17
        case popSemiBold19
        case popSemiBold13
        case popMid14
        case popMid16
        case popMid17
    }
    
    static func theme(_ fontType: FontType) -> UIFont {
        var font: UIFont?
        
        switch fontType {
        case .popSemiBold20:
            font = UIFont(name: "Poppins-SemiBold", size: 20.sizeH)
        case .popSemiBold22:
            font = UIFont(name: "Poppins-SemiBold", size: 22.sizeH)
        case .popExtraBold22:
            font = UIFont(name: "Poppins-Extrabold", size: 22.sizeH)
        case .popExtraBold24:
            font = UIFont(name: "Poppins-Extrabold", size: 24.sizeH)
        case .popExtraBold32:
            font = UIFont(name: "Poppins-Extrabold", size: 32.sizeH)
        case .popReg25:
            font = UIFont(name: "Poppins-Regular", size: 25.sizeH)
        case .popReg15:
            font = UIFont(name: "Poppins-Regular", size: 15.sizeH)
        case .popReg13:
            font = UIFont(name: "Poppins-Regular", size: 13.sizeH)
        case .popReg17:
            font = UIFont(name: "Poppins-Regular", size: 17.sizeH)
        case .popSemiBold15:
            font = UIFont(name: "Poppins-SemiBold", size: 15.sizeH)
        case .popSemiBold17:
            font = UIFont(name: "Poppins-SemiBold", size: 17.sizeH)
        case .popSemiBold19:
            font = UIFont(name: "Poppins-SemiBold", size: 19.sizeH)
        case .popSemiBold13:
            font = UIFont(name: "Poppins-SemiBold", size: 13.sizeH)
        case .popMid14:
            font = UIFont(name: "Poppins-Medium", size: 14.sizeH)
        case .popMid16:
            font = UIFont(name: "Poppins-Medium", size: 16.sizeH)
        case .popMid17:
            font = UIFont(name: "Poppins-Medium", size: 17.sizeH)
        }
        
        // TODO: remove before project publish
        guard let font = font else {
            fatalError("Font \(fontType) not found")
        }
        
        return font
    }
}
