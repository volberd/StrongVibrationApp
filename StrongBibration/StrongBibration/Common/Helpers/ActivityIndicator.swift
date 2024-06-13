//
//  ActivityIndicator.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import Foundation
import UIKit

class ActivityIndicator: UIView {
    
    //in px
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var rotationAngle: CGFloat = 0
    
    private var forceStopAnimation = false {
        didSet {
            isHidden = forceStopAnimation
        }
    }
    private var isRotating = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        isHidden = true
        backgroundColor = .clear
    }
    
    func startAnimating() {
        if !isRotating {
            forceStopAnimation = false
            
            //возвращаем в исходную
            rotationAngle = 0
            self.transform = .identity
            
            rotate()
        }
    }
    
    func stopAnimating() {
        forceStopAnimation = true
    }
    
    private func rotate() {
        isRotating = true
        self.rotationAngle += 90
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: self.rotationAngle.degreesToRadians)
        }) { finished in
            if !self.forceStopAnimation {
                self.rotate()
            } else {
                self.isRotating = false
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        //bottom line
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 360
        
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2-lineWidth,
                                startAngle: startAngle.degreesToRadians,
                                endAngle: endAngle.degreesToRadians,
                                clockwise: true)
        
        path.lineWidth = lineWidth
        UIColor.clear.setStroke()
        path.stroke()
        
        startAngle = 270
        endAngle = 540
        
        path = UIBezierPath(arcCenter: center,
                            radius: radius/2-lineWidth,
                            startAngle: startAngle.degreesToRadians,
                            endAngle: endAngle.degreesToRadians,
                            clockwise: true)
        
        path.lineWidth = lineWidth
        UIColor.white.setStroke()
        path.stroke()
    }
}
