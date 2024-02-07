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
    
    private lazy var backgroundImage: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "baseBackgroundImage")
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    lazy var notVibrationButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Not vibrating?", for: .normal)
        return obj
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
    
    private let softLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Soft"
        obj.font = .systemFont(ofSize: 14, weight: .medium)
        obj.textColor = .white
        return obj
    }()
    
    private let hardLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Hard"
        obj.font = .systemFont(ofSize: 14, weight: .medium)
        obj.textColor = .white
        return obj
    }()
    
    private let customSlider: Slider = {
        let obj = Slider()
        obj.backgroundColor = .clear
        return obj
    }()
    
    private lazy var pinkShadowImageView: UIImageView = {
        let obj = UIImageView()
        obj.isHidden = true
        obj.image = UIImage(named: "pinkShadow")
        return obj
    }()
    
    private lazy var sliderImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "sliderImage")
        return obj
    }()
    
    lazy var vibrateButton: UIButton = {
        let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "onButton"), for: .normal)
        return obj
        
    }()
    
    let segmentedControl: CustomSegmentedControl  = {
        let obj = CustomSegmentedControl(items: ChooseModelControl.allCases.map({$0.title}))
        return obj
    }()
    
    private lazy var waveView: UIView = {
        let obj = UIView()
        
        return obj
    }()
    
    let stateStackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .vertical
        return obj
    }()
    
    let pressButtonTitle: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.numberOfLines = 2
        obj.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "Press the button\n", attributes: [
            .font: UIFont.systemFont(ofSize: 14.sizeW, weight: .medium),
            .foregroundColor: UIColor.white
        ])
        
        attributedText.append(NSAttributedString(string: "to start vibration", attributes: [
            .font: UIFont.systemFont(ofSize: 8.sizeW, weight: .medium),
            .foregroundColor: UIColor.white
        ]))
        
        obj.attributedText = attributedText
        return obj
    }()
    
    var stateView: ChooseStateView = {
        let obj = ChooseStateView()
        obj.isHidden = true
        obj.model = ChooseStateModel(title: "Vulcano", icon: "tornado")
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
        addSubview(backgroundImage)
        addSubview(sliderImageView)
        addSubview(pinkShadowImageView)
        addSubview(notVibrationButton)
        addSubview(musicButton)
        addSubview(lockButton)
        addSubview(waveView)
        addSubview(vibrateButton)
        addSubview(customSlider)
        addSubview(softLabel)
        addSubview(hardLabel)
        addSubview(segmentedControl)
        addSubview(stateStackView)
        
        stateStackView.addArrangedSubview(pressButtonTitle)
        stateStackView.addArrangedSubview(stateView)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        notVibrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(lockButton.snp.centerY)
        }
        
        vibrateButton.snp.makeConstraints { make in
            make.size.equalTo(160.sizeH)
            make.centerX.equalToSuperview()
            make.top.equalTo(notVibrationButton.snp.bottom).offset(68.sizeH)
        }
        
        pinkShadowImageView.snp.makeConstraints { make in
            make.size.equalTo(300.sizeH)
            make.center.equalTo(vibrateButton.snp.center)
        }
        
        waveView.snp.makeConstraints { make in
            make.size.equalTo(146.sizeH)
            make.center.equalTo(vibrateButton.snp.center)
        }
        
        sliderImageView.snp.makeConstraints { make in
            make.height.equalTo(10.sizeH)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-133.sizeH)
            make.leading.trailing.equalToSuperview().inset(39.sizeW)
        }
        
        customSlider.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-129.sizeH)
            make.leading.trailing.equalToSuperview().inset(39.sizeW)
        }
        
        softLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32.sizeW)
            make.bottom.equalTo(customSlider.snp.top).offset(-8.sizeH)
        }
        
        hardLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(32.sizeW)
            make.bottom.equalTo(customSlider.snp.top).offset(-8.sizeH)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(60.sizeW)
            make.height.equalTo(40.sizeH)
            make.bottom.equalTo(hardLabel.snp.top).offset(-40.sizeH)
        }
        
        stateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(vibrateButton.snp.bottom).offset(25.sizeH)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        gradientLayer.frame = bounds
    }
    
    func animateWaveView() {
        createPulse()
        
        vibrateButton.setBackgroundImage(UIImage(named: "tapedButton"), for: .normal)
        pinkShadowImageView.isHidden = false
        stateView.isHidden = false
        pressButtonTitle.isHidden = true
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
        pinkShadowImageView.isHidden = true
        stateView.isHidden = true
        pressButtonTitle.isHidden = false
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
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
