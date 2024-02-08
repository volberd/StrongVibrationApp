//
//  PatternCollectionViewCell.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 03.02.2024.
//

import UIKit

class PatternCollectionViewCell: UICollectionViewCell, Reusable {
    let baseView: UIView = {
        let obj = UIView()
        return obj
    }()
    
    private let baseImageView: UIImageView = {
       let obj = UIImageView()
        obj.image = UIImage(named: "basePattersImage")
        return obj
    }()

    private let iconImageView: UIImageView = {
       let obj = UIImageView()
        obj.tintColor = .white
        obj.contentMode = .center
        return obj
    }()

    
    private var titleLabel: UILabel = {
       let obj = UILabel()
        obj.font = .systemFont(ofSize: 12.sizeW, weight: .regular)
        obj.text = "Some te"
        obj.textAlignment = .center
        obj.textColor = .white
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
        
        addSubview(baseView)
        baseView.addSubview(baseImageView)
        baseImageView.addSubview(iconImageView)
        baseView.addSubview(titleLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseImageView.snp.makeConstraints { make in
            make.size.equalTo(65.sizeW)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.sizeH)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8.sizeW)
            make.top.equalTo(baseImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func setupCell(model: PatternModel) {
        titleLabel.text = model.title
        if let iconImage = UIImage(named: model.iconString) {
               iconImageView.image = iconImage.withRenderingMode(.alwaysTemplate)
           }
    }
}
