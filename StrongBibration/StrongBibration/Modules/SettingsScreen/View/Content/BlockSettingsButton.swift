//
//  BlockSettingsButton.swift
//  StrongVibration
//
//  Created by Vova Kolomyltsev on 01.02.2024.
//

import Foundation
import UIKit
import SnapKit

class BlockSettingsButton: UIButton {
    
    var model: SettingsButtonModel? {
        didSet {
            guard let model = model else { return }
            handleUI()
        }
    }

    private let icon: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    private let arrowIcon: UIImageView = {
       let obj = UIImageView()
        obj.image = UIImage(named: "arrowIcon")
        return obj
    }()
    
    private let title: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 15)
        obj.textColor = .white
        return obj
    }()
    
    private let separatorView: UIView = {
       let obj = UIView()
        obj.backgroundColor = .white.withAlphaComponent(0.4)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
 
    private func handleUI() {
        guard let model = model else { return }
        icon.image = UIImage(named: model.icon)
        title.text = model.title
        arrowIcon.isHidden = !model.isArrow
        separatorView.isHidden = !model.isSeparatorView
    }
    
    private func setup() {
        addSubview(icon)
        addSubview(title)
        addSubview(arrowIcon)
        addSubview(separatorView)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16.sizeW)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16.sizeW)
            make.height.equalTo(16.sizeH)
            make.width.equalTo(10.sizeW)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(8.sizeW)
            make.trailing.equalTo(arrowIcon.snp.leading).offset(-8.sizeW)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

struct SettingsButtonModel {
    var title: String
    var icon: String
    var isArrow: Bool
    var isSeparatorView: Bool
}
