//
//  GenresModel.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 05.02.2024.
//

import Foundation

enum GenresModel: CaseIterable {
    case favorite
    case calm
    case happy
    case meditation
    case rock
    case pop
    case jazz
    case classical
    case electronic
    case hipHop
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorite"
        case .calm:
            return "Calm"
        case .happy:
            return "Happy"
        case .meditation:
            return "Meditation"
        case .rock:
            return "Rock"
        case .pop:
            return "Pop"
        case .jazz:
            return "Jazz"
        case .classical:
            return "Classical"
        case .electronic:
            return "Electronic"
        case .hipHop:
            return "Hip Hop"
        }
    }
}
