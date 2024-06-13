//
//  PaywallView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit

class PaywallView: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.darkGradientPink).cgColor, UIColor.theme(.lightGradientPink).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
     let closeButton: UIButton = {
       let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "closeIcon"), for: .normal)
        return obj
    }()
    
    private let unlockLabel : UILabel = {
       let obj = UILabel()
        obj.text = "Unlock \nEverything"
        obj.numberOfLines = 2
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 32.sizeW, weight: .heavy)
        obj.textColor = .white
        return obj
    }()
    
    private let noAddsLabel = ListPaywallView("No Adds", subtitle: "Disable all ads in the app")
    
    private let allVibrationLabel = ListPaywallView("All vibration patterns", subtitle: "9 selected modes")
    
    private let allMusicLabel = ListPaywallView("All music library", subtitle: "Access to the relaxing music library")
    
    private let descriptionStackView: UIStackView = {
       let obj = UIStackView()
        obj.axis = .vertical
        obj.spacing = 16.sizeH
        obj.alignment = .leading
        return obj
    }()
    
     let activateButton: UIButton = {
       let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "subscriptionButton"), for: .normal)
        obj.setTitle("TRY FOR FREE", for: .normal)
        obj.titleLabel?.font = .systemFont(ofSize: 17.sizeW, weight: .heavy)
        return obj
    }()
    
    private let trialLabel: UILabel = {
       let obj = UILabel()
        obj.text = "3 days for free, then 3$ per week"
        obj.textColor = .black
        obj.font = .systemFont(ofSize: 10.sizeW, weight: .regular)
        return obj
    }()
    
    private let tipsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 9.sizeW, weight: .regular)
        
        let text = NSMutableAttributedString(string: "You will pay nothing if you cancel within 7 days. After the trial period, the subscription will automatically renew. You may cancel renewal at any time. View more details: ")
        
        let eulaLinkRange = NSRange(location: text.length, length: 4)
        let eulaLinkAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue, .underlineStyle: NSUnderlineStyle.single.rawValue]
        let eulaLinkString = NSAttributedString(string: "EULA", attributes: eulaLinkAttributes)
        text.append(eulaLinkString)
        
        let privacyLinkRange = NSRange(location: text.length, length: 14)
        let privacyLinkAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue, .underlineStyle: NSUnderlineStyle.single.rawValue]
        let privacyLinkString = NSAttributedString(string: " Privacy Policy", attributes: privacyLinkAttributes)
        text.append(privacyLinkString)
        
        label.attributedText = text
        
        // Add tap gesture recognizer for EULA
        let eulaTapGesture = UITapGestureRecognizer(target: self, action: #selector(eulaTapped))
        label.addGestureRecognizer(eulaTapGesture)
        label.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer for Privacy Policy
        let privacyTapGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyTapped))
        label.addGestureRecognizer(privacyTapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()

    
    @objc private func eulaTapped() {
        print("EULA нажата")
    }
    
    @objc private func privacyPolicyTapped() {
        print("Privacy Policy нажата")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.addSublayer(gradientLayer)
        addSubview(closeButton)
        addSubview(unlockLabel)
        addSubview(descriptionStackView)
        addSubview(activateButton)
        addSubview(trialLabel)
        addSubview(tipsLabel)
        
        descriptionStackView.addArrangedSubview(noAddsLabel)
        descriptionStackView.addArrangedSubview(allVibrationLabel)
        descriptionStackView.addArrangedSubview(allMusicLabel)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.sizeH)
            make.size.equalTo(16.sizeW)
            make.leading.equalToSuperview().inset(36.sizeW)
        }
        
        unlockLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom).offset(44.sizeH)
        }
        
        descriptionStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(56.sizeW)
            make.top.equalTo(unlockLabel.snp.bottom).offset(30.sizeH)
        }
        
        activateButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32.sizeW)
            make.top.equalTo(descriptionStackView.snp.bottom).offset(128.sizeH)
            make.height.equalTo(53.sizeH)
        }
        
        trialLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activateButton.snp.bottom).offset(8.sizeH)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(29.sizeW)
            make.bottom.equalToSuperview().offset(-32.sizeH)
        }
        
        noAddsLabel.snp.makeConstraints { make in
            make.height.equalTo(40.sizeH)
        }
        
        allMusicLabel.snp.makeConstraints { make in
            make.height.equalTo(40.sizeH)
        }
        
        allVibrationLabel.snp.makeConstraints { make in
            make.height.equalTo(40.sizeH)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
