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
    
    private var storeKit = SubscriptionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
}

//:- Actions
extension SettingsViewController {
    @objc
    private func unlockButtonTapped() {
        subscriptionHandler()
    }
}


//MARK: Logic for subscriptions
extension SettingsViewController {
    
    func subscriptionHandler() {
        if CachingManager.shared.isSubscriptionActive {
          
        } else {
            if storeKit.purchasedSubscriptions.isEmpty {
            Task {
                
                if storeKit.purchasedSubscriptions.isEmpty {
                    presentSubscriptionHandler()
                } else {
                    if let restoreDate = CachingManager.shared.expirationDate {
                        if Date().timeIntervalSince1970 < restoreDate {
                        } else {
                            presentSubscriptionHandler()
                        }
                    } else {
//                        DateManager.shared.getSubscriptionExpirationDate()
                        let restoreDate = CachingManager.shared.expirationDate
                        if Date().timeIntervalSince1970 < restoreDate ?? 0 {
                        } else {
                            presentSubscriptionHandler()
                        }
                    }
                }
            }
        } else {
            if let restoreDate = CachingManager.shared.expirationDate {
                if Date().timeIntervalSince1970 < restoreDate {
                } else {
                    presentSubscriptionHandler()
                }
            } else {
//                DateManager.shared.getSubscriptionExpirationDate()
                let restoreDate = CachingManager.shared.expirationDate
                if Date().timeIntervalSince1970 < restoreDate ?? 0 {
                } else {
                    presentSubscriptionHandler()
                }
            }
        }
        }
   }
    
    private func presentSubscriptionHandler() {
        let subcriptionViewController =  NewPaywallViewController(storeKit: storeKit, completion: testHandler)
            subcriptionViewController.modalPresentationStyle = .fullScreen
            subcriptionViewController.modalTransitionStyle = .crossDissolve
//            subcriptionViewController.mainView.infoLabel.text = "\(storeKit.storeProducts.first?.price ?? 0)$"
            present(subcriptionViewController, animated: true)
    }
    
    private func testHandler() {
        let alert = UIAlertController(title: "Congradulations!", message: "Success by subscription", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
}
