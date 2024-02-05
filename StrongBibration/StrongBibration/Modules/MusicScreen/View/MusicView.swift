//
//  MusicView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 02.02.2024.
//

import UIKit
import SnapKit

class MusicView: UIView {
    
    private lazy var backgroundImage: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "baseBackgroundImage")
        return obj
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        return button
    }()
    
    private var doneButton: UIButton = {
       let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: ""), for: .normal)
        obj.setTitle("", for: .normal)
        return obj
    }()
    
    let titlesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.sizeW
        layout.minimumInteritemSpacing = 8.sizeW
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.backgroundColor = .clear
        return obj
    }()
    
    let listsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.backgroundColor = .clear
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
        addSubview(backButton)
        
        addSubview(titlesCollectionView)
        addSubview(listsCollectionView)
        addSubview(doneButton)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(39.sizeH)
            make.leading.equalToSuperview().inset(24.sizeW)
            make.top.equalToSuperview().inset(69.sizeH)
        }
        
        titlesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(32.sizeH)
            make.leading.equalToSuperview().offset(8.sizeW)
            make.trailing.equalToSuperview()
            make.height.equalTo(48.sizeH)
        }
        
        listsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titlesCollectionView.snp.bottom).offset(24.sizeH)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(36.sizeW)
            make.height.equalTo(42.sizeH)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40.sizeH)
        }
    }
    
}
