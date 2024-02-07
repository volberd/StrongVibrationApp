//
//  PopupView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 07.02.2024.
//

import UIKit
import SnapKit

class PopupView: UIView {

    private var popupView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .yellow
        obj.layer.cornerRadius = 38.sizeH
        obj.isUserInteractionEnabled = true

        return obj
    }()
    
    private var popupImageView: UIImageView = {
       let obj = UIImageView()
        obj.image = UIImage(named: "popPupImage")
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    let backButton: UIButton = {
        let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "leftArrow"), for: .normal)
        return obj
    }()
    
    private let notVibrationLabel: UILabel = {
       let obj = UILabel()
        obj.text = "Not vibration?"
        obj.textColor = .white
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 18.sizeW, weight: .semibold)
        return obj
    }()
    
    private var separatorView: UIView = {
       let obj = UIView()
        obj.backgroundColor = .black.withAlphaComponent(0.2)
        return obj
    }()
    
    private let checkLabel: UILabel = {
       let obj = UILabel()
        obj.text = "Check that vibration is enabled on your device."
        obj.textColor = .white
        obj.textAlignment = .left
        obj.numberOfLines = 0
        obj.font = .systemFont(ofSize: 12.sizeW, weight: .medium)
        return obj
    }()
    
    private let wayLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.numberOfLines = 2
        obj.textAlignment = .left
        
        let attributedText = NSMutableAttributedString(string: "Settings -> Sound -> Turn ON\n", attributes: [
            .font: UIFont.systemFont(ofSize: 14.sizeW, weight: .medium),
            .foregroundColor: UIColor.white
        ])
        
        attributedText.append(NSAttributedString(string: "’During a call’", attributes: [
            .font: UIFont.systemFont(ofSize: 14.sizeW, weight: .bold),
            .foregroundColor: UIColor.white
        ]))
        
        attributedText.append(NSAttributedString(string: " or ", attributes: [
            .font: UIFont.systemFont(ofSize: 14.sizeW, weight: .medium),
            .foregroundColor: UIColor.white
        ]))
        
        attributedText.append(NSAttributedString(string: "‘In silent mode’", attributes: [
            .font: UIFont.systemFont(ofSize: 14.sizeW, weight: .bold),
            .foregroundColor: UIColor.white
        ]))
        
        obj.attributedText = attributedText
        return obj
    }()
    
    let toTheSettingsButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("To the settings >", for: .normal)
        obj.setTitleColor(.black, for: .normal)
        obj.contentHorizontalAlignment = .left
        obj.titleLabel?.font = .systemFont(ofSize: 14.sizeW)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "To the settings >", attributes: attributes)
        obj.setAttributedTitle(attributedString, for: .normal)
        
        return obj
    }()

    
    let goItButton: UIButton = {
        let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "goItImage"), for: .normal)
        obj.setTitle("Got it", for: .normal)
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
        addSubview(popupView)
        popupView.addSubview(popupImageView)
        popupView.addSubview(backButton)
        popupView.addSubview(notVibrationLabel)
        popupView.addSubview(separatorView)
        popupView.addSubview(checkLabel)
        popupView.addSubview(goItButton)
        popupView.addSubview(wayLabel)
        popupView.addSubview(toTheSettingsButton)
    }
    
    private func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(324.sizeH)
            make.width.equalTo(288.sizeW)
        }
        
        popupImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28.sizeH)
            make.leading.equalToSuperview().inset(28.sizeW)
            make.size.equalTo(18.sizeH)
        }
        
        notVibrationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5.sizeH)
            make.top.equalTo(notVibrationLabel.snp.bottom).offset(23.sizeH)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView).offset(20.sizeH)
            make.leading.trailing.equalToSuperview().inset(26.sizeW)
        }
        
        wayLabel.snp.makeConstraints { make in
            make.top.equalTo(checkLabel.snp.bottom).offset(34.sizeH)
            make.leading.trailing.equalToSuperview().inset(26.sizeW)
        }
        
        toTheSettingsButton.snp.makeConstraints { make in
            make.bottom.equalTo(goItButton.snp.top).offset(-16.sizeH)
            make.leading.equalToSuperview().inset(26.sizeW)
            make.height.equalTo(34.sizeH)
        }
        
        goItButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(26.sizeH)
            make.centerX.equalToSuperview()
            make.height.equalTo(40.sizeH)
            make.width.equalTo(187.sizeW)
        }
        
    }
}
