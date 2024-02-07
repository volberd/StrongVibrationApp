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
        obj.text = "Not vibration?"
        obj.textColor = .white
        obj.font = .systemFont(ofSize: 18.sizeW, weight: .regular)
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
        
        goItButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(26.sizeH)
            make.centerX.equalToSuperview()
            make.height.equalTo(40.sizeH)
            make.width.equalTo(187.sizeW)
        }
    }
}
