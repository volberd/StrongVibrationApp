//
//  ChooseStateView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 07.02.2024.
//

import Foundation
import UIKit
import SnapKit

class ChooseStateView: UIView {
    
    var model: ChooseStateModel? {
        didSet {
            guard let model = model else { return }
            handleUI()
        }
    }
    
    private let icon: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    private let title: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 12.sizeW)
        obj.text = "Mode"
        obj.textColor = .white.withAlphaComponent(0.7)
        return obj
    }()
    
    private let stateTitle: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 15)
        obj.text = "Vulkano"
        obj.textColor = .white
        return obj
    }()
    
    private let bottomStackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.spacing = 9.sizeW
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
        stateTitle.text = model.title
    }
    
    private func setup() {
        addSubview(icon)
        addSubview(title)
        addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(stateTitle)
        bottomStackView.addArrangedSubview(icon)
        
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(0.sizeH)
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(16.sizeH)
        }
    }
}

struct ChooseStateModel {
    var title: String
    var icon: String
}
