//
//  PatternsViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class PatternsViewController: UIViewController {

    private let mainView = PatternsView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}
