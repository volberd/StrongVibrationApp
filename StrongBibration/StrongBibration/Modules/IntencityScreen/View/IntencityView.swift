//
//  IntencityView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit

class IntensityView: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.lightGradientPink).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    private let notVibtaionLabel: UILabel = {
       let obj = UILabel()
        obj.text = "Not vibrating?"
        obj.font = .systemFont(ofSize: 14.sizeH, weight: .regular)
        obj.textColor = .white
        obj.textAlignment = .center
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.addSublayer(gradientLayer)
        
        addSubview(notVibtaionLabel)
        
        notVibtaionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(16.sizeH)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

