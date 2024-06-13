//
//  SettingsView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.lightGradientPink).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    private let settingsLabel: UILabel = {
       let obj = UILabel()
        obj.font = .systemFont(ofSize: 25.sizeH, weight: .semibold)
        obj.text = "Settings"
        obj.textColor = .theme(.white)
        return obj
    }()
    
    private let baseStackView: UIStackView = {
       let obj = UIStackView()
        obj.axis = .vertical
        obj.spacing = 36.sizeH
        return obj
    }()
    
    private let buttonsStackView: UIStackView = {
       let obj = UIStackView()
        obj.axis = .vertical
        obj.spacing = 21.sizeH
        return obj
    }()
    
    let unlockButton: PaywallButton = {
       let obj = PaywallButton()
        obj.model = PaywallButtonModel(title: "Unlock everyting", icon: "unlockIcon")
        obj.layer.cornerRadius = 7.sizeH
        obj.setBackgroundImage(UIImage(named: "unlockButtonImage"), for: .normal)
        return obj
    }()
    
    let notVibrationButton: BlockSettingsButton = {
       let obj = BlockSettingsButton()
        obj.model = SettingsButtonModel(
            title: "Not vibration?",
            icon: "vibrationIcon",
            isArrow: false,
            isSeparatorView: false)
        obj.layer.cornerRadius = 7.sizeH
        obj.setBackgroundImage(UIImage(named: "customButtonBackground"), for: .normal)
        return obj
    }()
    
    let rateButton: BlockSettingsButton = {
       let obj = BlockSettingsButton()
        obj.model = SettingsButtonModel(
            title: "Rate the App",
            icon: "starIcon",
            isArrow: true,
            isSeparatorView: true)
        return obj
    }()
    
    let shareButton: BlockSettingsButton = {
       let obj = BlockSettingsButton()
        obj.model = SettingsButtonModel(
            title: "Share",
            icon: "shareIcon",
            isArrow: true,
            isSeparatorView: true)
        return obj
    }()
    
    let sendFeedbackButton: BlockSettingsButton = {
       let obj = BlockSettingsButton()
        obj.model = SettingsButtonModel(
            title: "Send feedback",
            icon: "mailIcon",
            isArrow: true,
            isSeparatorView: false)
        return obj
    }()
    
    private let blockImageView: UIImageView = {
       let obj = UIImageView()
        obj.image = UIImage(named: "customBlockImage")
        obj.clipsToBounds = true
        obj.isUserInteractionEnabled = true

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
        addSubview(settingsLabel)
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(unlockButton)
        baseStackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(notVibrationButton)
        buttonsStackView.addArrangedSubview(blockImageView)
        
        blockImageView.addSubview(rateButton)
        blockImageView.addSubview(shareButton)
        blockImageView.addSubview(sendFeedbackButton)
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(8.sizeH)
            make.leading.equalToSuperview().inset(18.sizeW)
        }
        
        baseStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32.sizeW)
            make.top.equalTo(settingsLabel.snp.bottom).offset(48.sizeH)
        }
        
        blockImageView.snp.makeConstraints { make in
            make.height.equalTo(186.sizeH)
        }
        
        rateButton.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(186.sizeH / 3)
        }
        
        shareButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(rateButton.snp.bottom)
            make.height.equalTo(186.sizeH / 3)
        }
        
        sendFeedbackButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(186.sizeH / 3)
        }
        
        notVibrationButton.snp.makeConstraints { make in
            make.height.equalTo(63.sizeH)
        }
        
        unlockButton.snp.makeConstraints { make in
            make.height.equalTo(53.sizeH)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
