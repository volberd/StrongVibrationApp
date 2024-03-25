//
//  PatternModel.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 08.02.2024.
//

class ArrayPaternModelControl {
    static var copies: [PatternModel] = {
        var arr = [PatternModel]()
        arr.append(PatternModel(id: 0,
                                iconString: "pluse",
                                title: "Create",
                                isBlok: true))
        arr.append(PatternModel(id: 1,
                                iconString: "tornado",
                                title: "Tornado",
                                isBlok: false))
        arr.append(PatternModel(id: 2,
                                iconString: "vulcano",
                                title: "Volcano",
                                isBlok: false))
        arr.append(PatternModel(id: 3,
                                iconString: "breathe",
                                title: "Breeze",
                                isBlok: false))
        arr.append(PatternModel(id: 4,
                                iconString: "impuls",
                                title: "Pattern 4",
                                isBlok: true))
        arr.append(PatternModel(id: 5,
                                iconString: "waveIcon",
                                title: "Pattern 5",
                                isBlok: true))
        arr.append(PatternModel(id: 6,
                                iconString: "cloud",
                                title: "Pattern 6",
                                isBlok: true))
        arr.append(PatternModel(id: 8,
                                iconString: "alarm",
                                title: "Pattern 7",
                                isBlok: true))
        arr.append(PatternModel(id: 9,
                                iconString: "key",
                                title: "Pattern 8",
                                isBlok: true))
        return arr
    }()
}

struct PatternModel {
    let id: Int
    let iconString: String
    let title: String
    let isBlok: Bool
}
