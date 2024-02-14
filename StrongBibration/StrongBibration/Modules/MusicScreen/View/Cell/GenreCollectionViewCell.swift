//
//  GenreCollectionViewCell.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 05.02.2024.
//

import UIKit
import SnapKit

class GenreCollectionViewCell: UICollectionViewCell {
    var model: GenresModel? {
        didSet {
            handleUI()
        }
    }
    
    var isActive: Bool = false {
        didSet {
            activeUI()
        }
    }
    
    private let baseImageView: UIImageView = {
     let obj = UIImageView()
        obj.image = UIImage(named: "baseImageCell")
        return obj
    }()

    private var titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .theme(.white)
        obj.textAlignment = .center
//        obj.backgroundColor = .theme(.white)
        obj.font = UIFont.systemFont(ofSize: 14.sizeW, weight: .regular)
        return obj
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Setup
extension GenreCollectionViewCell {
    private func handleUI() {
        guard let model else {
            return
        }
        titleLabel.text = model.title
        
    }
    
    private func activeUI() {
        if isActive {
            titleLabel.textColor = .theme(.lightPink)
            baseImageView.image = UIImage(named: "activeImageCell")
        } else {
            titleLabel.textColor = .theme(.white)
            baseImageView.image = UIImage(named: "baseImageCell")
        }
    }
    
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 17.sizeW
        
        addSubview(baseImageView)
        baseImageView.addSubview(titleLabel)

        makeConstraints()
    }
    
    private func makeConstraints() {
        baseImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
