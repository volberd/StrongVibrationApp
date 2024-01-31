//
//  PatternsNavigationController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class PatternsNavigationController: UINavigationController {
    init() {
        let mainScreenVC = PatternsViewController()
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

extension PatternsNavigationController {
    private func initNavigationController() {
        let mainTabBarItem = UITabBarItem(
            title: "Patterns",
            image: UIImage(named: "patternsIcon"),
            selectedImage: UIImage(named: "patternsIcon"))
        
        self.tabBarItem = mainTabBarItem
    }
}
