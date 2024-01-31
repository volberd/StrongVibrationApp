//
//  ListPaywallView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class ListPaywallView: UIView {
    
    private var containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .clear
        return obj
    }()
    
    private var imageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.image = UIImage(named: "doneIcon")
        return obj
    }()
    
    private var textLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .theme(.white)
        obj.font = UIFont.systemFont(ofSize: 16.sizeW, weight: .bold)
        obj.numberOfLines = 0
        return obj
    }()
    
    private var subTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .theme(.white)
        obj.font = UIFont.systemFont(ofSize: 12.sizeW, weight: .thin)
        obj.numberOfLines = 0
        return obj
    }()
    
    private var titlesStackView: UIStackView = {
        let obj = UIStackView()
        
        obj.axis = .vertical
        obj.spacing = 8.sizeH
        obj.alignment = .leading
        return obj
    }()
    
    init(_ title: String, subtitle: String) {
        super.init(frame: .zero)
        textLabel.text = title
        subTitleLabel.text = subtitle
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: setup
extension ListPaywallView {
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titlesStackView)
        
        titlesStackView.addArrangedSubview(textLabel)
        titlesStackView.addArrangedSubview(subTitleLabel)
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25.sizeW)
        }
        
        titlesStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8.sizeW)
            make.bottom.top.trailing.equalToSuperview()
        }
    }
}
