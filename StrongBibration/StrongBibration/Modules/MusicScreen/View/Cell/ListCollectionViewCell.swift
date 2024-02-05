//
//  ListCollectionViewCell.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 05.02.2024.
//

import UIKit
import SnapKit

class ListCollectionViewCell: UICollectionViewCell {
    var model: GenresModel? {
        didSet {
//            handleUI()
        }
    }
    
    var isActive: Bool = false {
        didSet {
            activeUI()
        }
    }
    
    private let baseView: UIView = {
     let obj = UIView()
        return obj
    }()
    
    private var leftStackView: UIStackView = {
       let obj = UIStackView()
        obj.axis = .horizontal
        obj.spacing = 16.sizeW
        return obj
    }()
    
    private var doneIconImageView: UIImageView = {
      let obj = UIImageView()
        obj.image = UIImage(named: "whiteChekIcon")
        obj.contentMode = .center
        obj.isHidden = true
        return obj
    }()
    
    private var musicIconImageView: UIImageView = {
      let obj = UIImageView()
        obj.image = UIImage(named: "musicButton")
        return obj
    }()
    
    private var nameLabel: UILabel = {
      let obj = UILabel()
        obj.text = "Sone text"
        obj.textColor = .white
        obj.font = .systemFont(ofSize: 13.sizeW, weight: .regular)
        return obj
    }()
    
    private var timeLabel: UILabel = {
      let obj = UILabel()
        obj.text = "3:08"
        obj.textColor = .white
        obj.font = .systemFont(ofSize: 11.sizeW, weight: .regular)
        return obj
    }()
    
    private var playButton: UIButton = {
      let obj = UIButton()
        obj.setBackgroundImage(UIImage(named: "playIcon"), for: .normal)
        return obj
    }()
    
    private var separatorView: UIView = {
       let obj = UIView()
        obj.backgroundColor = .white.withAlphaComponent(0.5)
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
extension ListCollectionViewCell {
    private func handleUI() {
        guard let model else {
            return
        }
        
    }
    
    private func activeUI() {
        if isActive {
//            baseImageView.image = UIImage(named: "activeImageCell")
        } else {
//            baseImageView.image = UIImage(named: "baseImageCell")
        }
    }
    
    
    private func setup() {
        addSubview(baseView)
        baseView.addSubview(leftStackView)
        baseView.addSubview(playButton)
        baseView.addSubview(nameLabel)
        baseView.addSubview(timeLabel)
        baseView.addSubview(separatorView)
        
        leftStackView.addArrangedSubview(doneIconImageView)
        leftStackView.addArrangedSubview(musicIconImageView)

        makeConstraints()
    }
    
    private func makeConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftStackView.snp.makeConstraints { make in
            make.height.equalTo(48.sizeH)
            make.centerY.equalToSuperview()
            make.leading.equalTo(32.sizeW)
        }
        
        doneIconImageView.snp.makeConstraints { make in
            make.size.equalTo(28.sizeH)
        }
        
        musicIconImageView.snp.makeConstraints { make in
            make.size.equalTo(48.sizeH)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftStackView.snp.trailing).offset(21)
            make.top.equalTo(leftStackView.snp.top).offset(6.sizeH)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftStackView.snp.trailing).offset(21)
            make.top.equalTo(nameLabel.snp.bottom).offset(6.sizeH)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(28.sizeH)
            make.trailing.equalToSuperview().inset(32.sizeW)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(80.sizeW)
            make.height.equalTo(1.sizeH)
        }
        
    }
}
