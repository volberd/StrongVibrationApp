//
//  LockViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 06.02.2024.
//

import UIKit

class LockViewController: UIViewController {
    private let mainView = LockView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    private func initViewController() {

    }
}


//MARK: - Actions
extension LockViewController {
 
}
