//
//  SubscribeButton.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import UIKit

class PaywallButton: UIButton {
    
    var model: PaywallButtonModel? {
        didSet {
            guard let model = model else { return }
            handleUI()
        }
    }

    let icon: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    let title: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 17.sizeH, weight: .heavy)
        obj.textColor = .white
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
    }
    
    private func setup() {
        addSubview(icon)
        addSubview(title)
        
        icon.snp.makeConstraints { make in
            make.height.equalTo(28.sizeH)
            make.width.equalTo(22.sizeH)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16.sizeW)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(8.sizeW)
            make.trailing.equalToSuperview().inset(16.sizeW)
        }
    }
}

struct PaywallButtonModel {
    var title: String
    var icon: String
}
