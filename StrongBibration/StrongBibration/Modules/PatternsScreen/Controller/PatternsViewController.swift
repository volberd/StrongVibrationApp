//
//  PatternsViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class PatternsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let mainView = PatternsView()
    private var allPatterns = ArrayPaternModelControl.copies
    private let storeKit = SubscriptionManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewSize()
    }
    
    private func initViewController() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.collectionView.registerReusableCell(PatternCollectionViewCell.self)
    }
}

//MARK: - makeConstraints

extension PatternsViewController {
    private func viewSize() {
        mainView.layer.cornerRadius = 30
        mainView.clipsToBounds = true
        
        mainView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(0)
            make.height.equalTo(460.sizeH)
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}

//MARK: - Setup CollectionView
extension PatternsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPatterns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatternCollectionViewCell", for: indexPath) as? PatternCollectionViewCell else {
            
            return UICollectionViewCell()
        }

        cell.setupCell(model: allPatterns[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8.0
               let availableWidth = collectionView.bounds.width - (spacing * 4)
        let availableheight = collectionView.bounds.height - (spacing * 4)
               let itemWidth = availableWidth / 3
        let itemheight = availableheight / 3
               return CGSize(width: itemWidth, height: itemheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !allPatterns[indexPath.row].isBlok {
            dismiss(animated: true) {
                let selectedModel = self.allPatterns[indexPath.row]
                NotificationCenter.default.post(name: NSNotification.Name("PatternSelected"), object: selectedModel)
            }
        } else {
            subscriptionHandler()
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
}
