//
//  PatternsView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit

class PatternsView: UIView {
    private let containerView: UIView = {
       let obj = UIView()
        obj.backgroundColor = .theme(.patternPink)
        obj.layer.borderColor = UIColor.white.cgColor
        obj.layer.borderWidth = 1
        obj.layer.cornerRadius = 30
        return obj
    }()
    
    let pressButtonTitle: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "Mode\n", attributes: [
            .font: UIFont.systemFont(ofSize: 10.sizeW, weight: .medium),
            .foregroundColor: UIColor.white
        ])
        
        obj.attributedText = attributedText
        return obj
    }()
    
    var selectedMode: UILabel = {
       let obj = UILabel()
        obj.font = .systemFont(ofSize: 18.sizeH, weight: .bold)
        obj.textColor = .white
        obj.text = "Vulcano"
        return obj
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.sizeW
        layout.minimumInteritemSpacing = 8.sizeW
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.backgroundColor = .clear
        obj.clipsToBounds = false
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
        addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(pressButtonTitle)
        containerView.addSubview(selectedMode)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pressButtonTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24.sizeH)
            make.centerX.equalToSuperview()
        }
        
        selectedMode.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pressButtonTitle.snp.bottom)
        }
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(280.sizeW)
            make.bottom.equalToSuperview().inset(32.sizeH)
            make.top.equalTo(selectedMode.snp.bottom).offset(16.sizeH)
            make.centerX.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
