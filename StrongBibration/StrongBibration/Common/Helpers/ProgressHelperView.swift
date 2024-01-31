//
//  ProgressHelperView.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import UIKit

class ProgressHelperView: UIView {
    var activityIndicator: ActivityIndicator = {
        let obj = ActivityIndicator()
        obj.tintColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
      
        addSubview(activityIndicator)
    
        activityIndicator.snp.makeConstraints { (make) in
            make.size.equalTo(64.sizeW)
            make.center.equalToSuperview()
        }

    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        activityIndicator.startAnimating()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
