//
//  MusicViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 02.02.2024.
//

import Foundation
import UIKit

class MusicViewController: UIViewController {

    private let mainView = MusicView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}
