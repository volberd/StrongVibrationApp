//
//  UIVIew + ext.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import Foundation
import UIKit

extension UIView {
    
    func gradientColor(bounds: CGRect, gradientLayer: CAGradientLayer) -> UIColor? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        let image = renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
        
        return UIColor(patternImage: image)
    }
    
    func makeGradient(colors: [UIColor], locations: [NSNumber], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, cornerRadius: CGFloat? = nil, type: CAGradientLayerType) {
        let gradientLayer = CAGradientLayer()
        if let radius = cornerRadius {
            gradientLayer.cornerRadius = radius
        }
        gradientLayer.type = type
        var cgColors: [CGColor] = []
        colors.forEach { color in
            cgColors.append(color.cgColor)
        }
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        if let start = startPoint,
           let end = endPoint {
            gradientLayer.startPoint = start //CGPoint(x: 0.78, y: 0.0)
            gradientLayer.endPoint = end //CGPoint(x: 0.0, y: 1.0)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradient(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradient(colorOne: UIColor, colorTwo: UIColor, cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setRadialGradient(colorOne: UIColor, colorTwo: UIColor, cornerRadius: CGFloat) {
        let gradient = CAGradientLayer()
//        gradient.type = .radial
        gradient.cornerRadius = cornerRadius
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(rect: gradient.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.layer.addSublayer(gradient)
    }
}
