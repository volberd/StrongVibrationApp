//
//  LockView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 06.02.2024.
//

import UIKit
import SnapKit

class LockView: UIView {
    
    private lazy var backgroundImage: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "baseBackgroundImage")
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    private var blackView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .black.withAlphaComponent(0.7)
        return obj
    }()
    
    private lazy var lockImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "lockImageView")
        return obj
    }()
    
    private var massagerLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 10.sizeW, weight: .regular)
        obj.textColor = .white
        obj.text = "Massager is locked"
        return obj
    }()
    
    private var holdLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 14.sizeW, weight: .bold)
        obj.textColor = .white
        obj.text = "Hold the button to unlock"
        return obj
    }()
    
    lazy var holdButton: UIButton = {
       let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "holdButtonImage"), for: .normal)
        obj.setTitle("Unlock", for: .normal)
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
        backgroundImage.addSubview(blackView)
        backgroundImage.addSubview(lockImageView)
        backgroundImage.addSubview(massagerLabel)
        backgroundImage.addSubview(holdLabel)
        backgroundImage.addSubview(holdButton)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lockImageView.snp.makeConstraints { make in
            make.size.equalTo(97.sizeH)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(228.sizeH)
        }
        
        massagerLabel.snp.makeConstraints { make in
            make.top.equalTo(lockImageView.snp.bottom).offset(56.sizeH)
            make.centerX.equalToSuperview()
        }
        
        holdLabel.snp.makeConstraints { make in
            make.top.equalTo(massagerLabel.snp.bottom).offset(8.sizeH)
            make.centerX.equalToSuperview()
        }
        
        holdButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(holdLabel.snp.bottom).offset(20.sizeH)
            make.height.equalTo(55.sizeH)
        }
    }
}
