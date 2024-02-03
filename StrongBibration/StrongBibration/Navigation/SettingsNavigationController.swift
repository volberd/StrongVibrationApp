//
//  SettingsNavigationController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class SettingsNavigationController: UINavigationController {
    init() {
        let mainScreenVC = SettingsViewController()
        super.init(rootViewController: mainScreenVC)
        initNavigationController()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsNavigationController {
    private func initNavigationController() {
        let mainTabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(named: ""),
            selectedImage: UIImage(named: ""))
        
        self.tabBarItem = mainTabBarItem
    }
}
