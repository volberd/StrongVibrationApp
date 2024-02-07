//
//  SettingsViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import SnapKit


class SettingsViewController: UIViewController {
    // MARK: - Properties
    
    private let mainView = SettingsView()
    private let storeKit = SubscriptionManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        mainView.unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
        mainView.notVibrationButton.addTarget(self, action: #selector(notVibrationButtonTapped), for: .touchUpInside)
        mainView.rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        mainView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        mainView.sendFeedbackButton.addTarget(self, action: #selector(feedbackButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Button Actions

extension SettingsViewController {
    @objc private func unlockButtonTapped() {
        subscriptionHandler()
    }
    
    @objc private func notVibrationButtonTapped() {
        print("Vibration button tapped")
        openVibrationSettings()
    }
    
    @objc private func rateButtonTapped() {
        print("Rate button tapped")
        
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(6475090898)?action=write-review") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func shareButtonTapped() {
        print("Share button tapped")
        
        let shareURL = URL(string: "https://apps.apple.com/app/id6475090898")!
        let activityViewController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    @objc private func feedbackButtonTapped() {
        print("Feedback button tapped")
        if let feedbackURL = URL(string: "mailto:massagertest@gmail.com?subject=Feedback") {
            UIApplication.shared.open(feedbackURL, options: [:], completionHandler: nil)
        }
    }
}


// MARK: - Subscription Handling

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
    
    private func openVibrationSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
