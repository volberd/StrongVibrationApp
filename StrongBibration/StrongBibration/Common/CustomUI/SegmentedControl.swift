//
//  SegmentedControl.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 03.02.2024.
//

import UIKit
import SnapKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControl(_ segmentedControl: CustomSegmentedControl, didSelectItemAt index: Int)
}


class CustomSegmentedControl: UIControl {
    private var items: [CustomControlItemView]
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private var selectedItem: CustomControlItemView? {
        willSet {
            selectedItem?.isSelected = false
        }
        didSet {
            backgroundView.isHidden = selectedItem == nil
            selectedItem?.isSelected = true
        }
    }
    
    var selectedIndex: Int? {
        if let selectedItem = selectedItem {
            return items.firstIndex(of: selectedItem)
        } else {
            return nil
        }
    }
    
    init(items: [String]) {
        self.items = []
        super.init(frame: .zero)
        
        items.forEach { item in
            self.items.append(CustomControlItemView(model: CustomSegmentedControlItem(title: item)))
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.distribution = .fillEqually
        obj.alignment = .fill
        obj.backgroundColor = .clear
        return obj
    }()
    
    private let backgroundView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .theme(.darkPink)
        obj.layer.cornerRadius = 18.sizeH
        obj.clipsToBounds = true
        //        obj.isHidden = true
        return obj
    }()
    
    private let customBacgroundImageView: UIImageView = {
       let obj = UIImageView()
        obj.image = UIImage(named: "customSegment")
        return obj
    }()
    
    private func setup() {
        layer.borderColor = UIColor.theme(.white).cgColor
        backgroundColor = .theme(.white)
        self.selectedItem = self.items[0]
        
        addSubview(backgroundView)
        backgroundView.addSubview(customBacgroundImageView)
        addSubview(stackView)
        
        items.forEach { item in
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didItemTap(_:))))
            stackView.addArrangedSubview(item)
        }
                
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.leading.equalToSuperview()
        }
        
        customBacgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.layer.cornerRadius = 20.sizeH
        self.layer.cornerRadius = 20.sizeH
    }
    
    func selectItem(index: Int, animate: Bool) {
        if index < items.count && index >= 0 {
            selectedItem = items[index]
            animateLine(item: items[index], animate: animate)
        }
    }

    @objc private func didItemTap(_ sender: UITapGestureRecognizer) {
        guard let itemView = sender.view as? CustomControlItemView,
            let index = items.firstIndex(where: { $0 == itemView }) else {
                return
        }
        
        self.selectedItem = items[index]
        
        self.delegate?.segmentedControl(self, didSelectItemAt: index)
        
        animateLine(item: items[index], animate: selectedItem != nil)
        self.sendActions(for: .valueChanged)
    }


    
    private func animateLine(item: CustomControlItemView, animate: Bool) {
        if animate {
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.snp.remakeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalToSuperview().dividedBy(3)
                    make.centerX.equalTo(item)
                }
                self.layoutIfNeeded()
            }
        } else {
            self.backgroundView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
                make.centerX.equalTo(item)
            }
        }
    }
}

//MARK: item model
extension CustomSegmentedControl {
    struct CustomSegmentedControlItem {
        let title: String
    }
}


//MARK: item view
extension CustomSegmentedControl {
    internal class CustomControlItemView: UIView {
        
        private var model: CustomSegmentedControlItem
        
        var isSelected: Bool = false {
            didSet {
                didSelect(isSelected)
            }
        }
        
        init(model: CustomSegmentedControlItem) {
            self.model = model
            super.init(frame: .zero)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private let titleLabel: UILabel = {
            let obj = UILabel()
            obj.font = UIFont.systemFont(ofSize: 14.sizeW, weight: .regular)
            obj.textColor = .theme(.lightPink)
            obj.textAlignment = .center
            return obj
        }()
        
        private func setup() {
            
            titleLabel.text = model.title
            
            
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        private func didSelect(_ isSelected: Bool) {
            titleLabel.textColor = isSelected ? UIColor.theme(.white) : UIColor.theme(.lightPink)
        }
    }
}
