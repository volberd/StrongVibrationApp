//
//  ChooseModelControl.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 07.02.2024.
//

import Foundation

enum ChooseModelControl: CaseIterable {
    case slow
    case medium
    case fast
    
    var title: String {
        switch self {
            
        case .slow:
            return "Slow"
        case .medium:
            return "Medium"
        case .fast:
            return "Fast"
        }
    }
}
