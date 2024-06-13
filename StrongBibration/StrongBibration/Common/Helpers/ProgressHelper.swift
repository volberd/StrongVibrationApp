//
//  ProgressHelper.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import UIKit

class ProgressHelper: NSObject {
    
    static var progressView: ProgressHelperView?
    
    static func show(progressText: String? = nil) {
        DispatchQueue.main.async {
            if progressView?.superview == nil {
                progressView = ProgressHelperView()
                
                if let keyWindow = UIApplication.shared.keyWindow,
                   let progressView = self.progressView {
                    keyWindow.addSubview(progressView)
                    progressView.activityIndicator.startAnimating()
                    
                    progressView.snp.makeConstraints { (make) in
                        make.edges.equalToSuperview()
                    }
                }
            }
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            self.progressView?.activityIndicator.stopAnimating()
            self.progressView?.removeFromSuperview()
        }
    }
}
