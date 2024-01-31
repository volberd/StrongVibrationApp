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
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(8.sizeH)
            make.leading.equalToSuperview().inset(18.sizeW)
        }
        
        baseStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32.sizeW)
            make.top.equalTo(settingsLabel.snp.bottom).offset(48.sizeH)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-170.sizeH)
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
