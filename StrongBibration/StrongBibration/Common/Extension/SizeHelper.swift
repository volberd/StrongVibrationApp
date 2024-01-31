//
//  SizeHelper.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import Foundation
import UIKit

extension BinaryFloatingPoint {
    private var size: CGSize {
        return CGSize(width: 360, height: 752)
    }
    
    /// iPhone Template: 414 x 896
    var sizeW: CGFloat {
        (CGFloat(self) * UIScreen.main.bounds.width / size.width).rounded(toPlaces: 0)
    }
    
    /// iPhone Template: 414 x 896
    var sizeH: CGFloat {
        (CGFloat(self) * UIScreen.main.bounds.height / size.height).rounded(toPlaces: 0)
    }
    
    /// iPhone Template: 414 x 896
    var lessThanOrEqualToSizeW: CGFloat {
        UIScreen.main.bounds.width < size.width ? self.sizeW : CGFloat(self)
    }
    
    /// iPhone Template: 414 x 896
    var lessThanOrEqualToSizeH: CGFloat {
        UIScreen.main.bounds.height < size.height ? self.sizeH : CGFloat(self)
    }
}

extension BinaryInteger {
    /// iPhone Template: 414 x 896
    var sizeW: CGFloat {
        CGFloat(self).sizeW
    }
    
    /// iPhone Template: 414 x 896
    var sizeH: CGFloat {
        CGFloat(self).sizeH
    }
    
    /// iPhone Template: 414 x 896
    var lessThanOrEqualToSizeW: CGFloat {
        CGFloat(self).lessThanOrEqualToSizeW
    }
    
    /// iPhone Template: 414 x 896
    var lessThanOrEqualToSizeH: CGFloat {
        CGFloat(self).lessThanOrEqualToSizeH
    }
}
