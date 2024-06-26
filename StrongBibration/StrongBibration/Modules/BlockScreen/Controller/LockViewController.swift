//
//  LockViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 06.02.2024.
//

import UIKit

class LockViewController: UIViewController {
    private let mainView = LockView()
    private let storeKit = SubscriptionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    private func initViewController() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(holdButtonLongPressed(_:)))
        mainView.holdButton.addGestureRecognizer(longPressGesture)
    }
}


//MARK: - Actions
extension LockViewController {
    @objc private func unlockButtonTapped() {
        dismiss(animated: true)
    }
    
    private func presentSubscriptionHandler() {
        let subscriptionViewController = NewPaywallViewController(storeKit: storeKit, completion: testHandler)
        subscriptionViewController.modalPresentationStyle = .fullScreen
        subscriptionViewController.modalTransitionStyle = .crossDissolve
        present(subscriptionViewController, animated: true)
    }
    
    private func testHandler() {
        let alert = UIAlertController(title: "Congratulations!", message: "Success with subscription", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func holdButtonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            unlockButtonTapped()
        }
    }
    
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
}
