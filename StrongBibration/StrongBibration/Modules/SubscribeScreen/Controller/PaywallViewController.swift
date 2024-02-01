//
//  PaywallViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import StoreKit

@available(iOS 15.0, *)
class NewPaywallViewController: UIViewController {
    
    var mainView: PaywallView
    private var currentSelectedIndex: Int = 0
    
    private let storeKitManager: SubscriptionManager
    private let successCompletion: () -> Void
    
    var subscriptionInfo: SKProduct? {
        didSet {
            updateSubscriptionLabels()
        }
    }
    
    @available(iOS 15.0, *)
    init(storeKit: SubscriptionManager, completion: @escaping () -> Void) {
        self.storeKitManager = storeKit
        self.successCompletion = completion
        self.mainView = PaywallView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        updateSubscriptionLabels()
    }

    private func setupUI() {
//        mainView.privacyButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
//        mainView.termsButton.addTarget(self, action: #selector(policyTapped), for: .touchUpInside)
//        mainView.restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
//        
        mainView.closeButton.addTarget(self, action: #selector(closeViewController(_:)), for: .touchUpInside)
        mainView.activateButton.addTarget(self, action: #selector(buyAdblocker), for: .touchUpInside)
    }
    
    private func updateSubscriptionLabels() {
        if let price = storeKitManager.storeProducts.first?.displayPrice {
//            mainView.infoLabel
//                .text = "3-day free trial, then \(price) per week."
        }
       
    }
    
    private func presentViewController(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}

// MARK: - Targets
@available(iOS 15.0, *)
extension NewPaywallViewController {
    @objc private func termsTapped() {
//        let termsViewController = TermsViewController()
//        presentViewController(termsViewController)
    }
    
    @objc private func policyTapped() {
//        let privacyViewController = PrivacyViewController()
//        presentViewController(privacyViewController)
    }
    
    @objc private func restoreTapped() {
        Task {
            if #available(iOS 15.0, *) {
                try? await SubscriptionManager.shared.restorePurchase()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @objc private func closeViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func isSubscriptionValid() -> Bool {
        guard let expirationDate = CachingManager.shared.expirationDate else {
            return false
        }

        let currentDate = Date().timeIntervalSince1970
        return expirationDate > currentDate
    }
    
    @objc
    private func buyAdblocker(_ sender: UIButton) {
        ProgressHelper.show()
        sender.isEnabled = false
    
        Task {
            defer {
                ProgressHelper.hide()
                
                sender.isEnabled = true
            }

            do {
                try await buySubscription()
            } catch {
                let alert = UIAlertController(title: "Fail!", message: "Error with subscription", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        }
    }

    @MainActor
    private func buySubscription() async throws {
        if CachingManager.shared.isSubscriptionActive {
            dismiss(animated: true)
            successCompletion()
            return
        }

        if let adblockerProduct = storeKitManager.storeProducts.first(where: { $0.id == SubscriptionsModel.subscriptionInfo["strongVibration"]}) {
            do {
                if let transaction = try await storeKitManager.purchase(adblockerProduct) {
                    CachingManager.shared.expirationDate = transaction.expirationDate?.timeIntervalSince1970 ?? 0
                    dismiss(animated: true)
                    successCompletion()
                }
            } catch {
                print("Error purchasing product: \(error)")
            }
        }
    }

}

// MARK: - Helpers
@available(iOS 15.0, *)
extension NewPaywallViewController {

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Fail!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
