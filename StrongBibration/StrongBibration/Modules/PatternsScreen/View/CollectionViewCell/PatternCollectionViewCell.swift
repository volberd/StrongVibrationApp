//
//  PatternCollectionViewCell.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 03.02.2024.
//

import UIKit

class PatternCollectionViewCell: UICollectionViewCell, Reusable {
    let premiumNotificationView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .yellow
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
        contentView.backgroundColor = .clear
        
        addSubview(premiumNotificationView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        premiumNotificationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
