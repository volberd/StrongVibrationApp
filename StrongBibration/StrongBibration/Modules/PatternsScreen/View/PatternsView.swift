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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.isPagingEnabled = true
        obj.backgroundColor = .clear
        obj.setCollectionViewLayout(layout, animated: true)
        obj.showsHorizontalScrollIndicator = false
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
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8.sizeH)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
