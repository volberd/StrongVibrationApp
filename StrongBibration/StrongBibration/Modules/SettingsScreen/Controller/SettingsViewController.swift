//
//  SettingsViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit


class SettingsViewController: UIViewController {
    private let mainView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}
