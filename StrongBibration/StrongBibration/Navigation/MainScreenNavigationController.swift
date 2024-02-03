//
//  MainScreenNavigationController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var isPreviusControllerNeedToChange = true
    private let gradientlayer = CAGradientLayer()
    private var selectedItem = 1
    
    var activeBar: UIView = {
        let obj = UIView()
        return obj
    }()
    
    private let feedbackGenerator: UIImpactFeedbackGenerator = {
        let obj = UIImpactFeedbackGenerator(style: .soft)
        obj.prepare()
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarController()
        self.tabBarController?.delegate = self
        setGradientBackground(colorOne: .theme(.darkPink), colorTwo: .theme(.tabBarPink))
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        gradientlayer.frame = tabBar.bounds
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0, 1]
        gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        self.tabBar.clipsToBounds = true
    }
}

extension MainTabBarController {
    private func initBarController() {
        initNavigationController()
        selectedIndex = viewControllers?.firstIndex(where: { $0 is IntensityNavigationController }) ?? 0
        setupActiveBar()
        self.delegate = self
    }

    
    private func customizeBarItem() {
        let cornerRadius: CGFloat = 20.sizeH
        tabBar.layer.cornerRadius = cornerRadius
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundColor = .theme(.tabBarPink)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .theme(.white)
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
    }
    
    private func initNavigationController() {
        customizeBarItem()

        let mainSettingsNavigationVC = SettingsNavigationController()
        let mainIntensityNavigationVC = IntensityNavigationController()
        let mainPatternsNavigationVC = PatternsNavigationController()

        viewControllers = [mainSettingsNavigationVC, mainIntensityNavigationVC, mainPatternsNavigationVC]
    }

        
    private func setupActiveBar() {
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
        let activeBarHeight: CGFloat = 2.0
        let activeBarColor: UIColor = .darkPink
        let newX = CGFloat(selectedIndex) * itemWidth
        activeBar = UIView(frame: CGRect(x: 0, y: 0, width: itemWidth - 40.sizeW, height: activeBarHeight))
        activeBar.backgroundColor = activeBarColor
        tabBar.addSubview(activeBar)
        activeBar.frame.origin.x = newX + 20.sizeW
    }
    
    private func presentPatternsViewControllerModally() {
        let patternsViewController = PatternsViewController() // Создание экземпляра PatternsViewController
        let navigationController = UINavigationController(rootViewController: patternsViewController) // Обертка в UINavigationController (если необходимо)
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true, completion: nil)
    }


}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        feedbackGenerator.impactOccurred()
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
        let selectedIndex = tabBarController.selectedIndex
        self.selectedItem = selectedIndex
        let newX = CGFloat(selectedIndex) * itemWidth
        UIView.animate(withDuration: 0.3) {
            self.activeBar.frame.origin.x = newX + 20.sizeW
        }
        tabBar.bringSubviewToFront(activeBar)

        if let navigationController = viewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is PatternsNavigationController {
            presentPatternsViewControllerModally()
            return false
        } else {
            return true
        }
    }
}

