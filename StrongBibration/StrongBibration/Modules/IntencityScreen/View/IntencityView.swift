//
//  IntencityView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit

class IntensityView: UIView {
    private let buttonSize: CGFloat = 61.sizeH
    private let buttonInset: CGFloat = 24.sizeW
    var pulseLayers = [CAShapeLayer]()
    var isAnimating: Bool {
        return !pulseLayers.isEmpty
    }
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.lightGradientPink).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    private lazy var notVibrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Not vibrating?"
        label.font = .systemFont(ofSize: 14.sizeH, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var musicButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "musicButton"), for: .normal)
        return button
    }()
    
    lazy var lockButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "lockButton"), for: .normal)
        return button
    }()
    
    lazy var vibrateButton: UIButton = {
        let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "onButton"), for: .normal)
        return obj
        
    }()
    
    private lazy var waveView: UIView = {
        let obj = UIView()
        
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        layer.addSublayer(gradientLayer)
        addSubview(notVibrationLabel)
        addSubview(musicButton)
        addSubview(lockButton)
        addSubview(waveView)
        addSubview(vibrateButton)
        
    }
    
    private func setupConstraints() {
        musicButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(buttonInset)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.size.equalTo(buttonSize)
        }
        
        lockButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(buttonInset)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.size.equalTo(buttonSize)
        }
        
        notVibrationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(lockButton.snp.centerY)
        }
        
        vibrateButton.snp.makeConstraints { make in
            make.size.equalTo(160.sizeH)
            make.centerX.equalToSuperview()
            make.top.equalTo(notVibrationLabel.snp.bottom).offset(68.sizeH)
        }
        
        waveView.snp.makeConstraints { make in
            make.size.equalTo(146.sizeH)
            make.center.equalTo(vibrateButton.snp.center)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func animateWaveView() {
        createPulse()
        
        vibrateButton.setBackgroundImage(UIImage(named: "tapedButton"), for: .normal)
    }
}

// MARK: - Animation
extension IntensityView {
    func stopAnimation() {
        for layer in pulseLayers {
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        }
        vibrateButton.setBackgroundImage(UIImage(named: "onButton"), for: .normal)
        pulseLayers.removeAll()
    }
    
    func createPulse() {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 5.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: waveView.frame.size.width/2.0, y: waveView.frame.size.width/2.0)
            waveView.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animatePulse(index: 2)
                }
            }
        }
    }
    
    func animatePulse(index: Int) {
        guard index < pulseLayers.count else {
            return
        }
        pulseLayers[index].strokeColor = UIColor.white.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
}
