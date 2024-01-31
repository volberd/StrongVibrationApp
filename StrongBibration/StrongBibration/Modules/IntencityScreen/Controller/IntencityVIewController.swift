//
//  IntencityVIewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class IntencityVIewController: UIViewController {
    private let mainView = IntensityView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}
