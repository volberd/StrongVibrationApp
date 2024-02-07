//
//  CustomPopupViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 06.02.2024.
//

import UIKit

class CustomPopupViewController: UIViewController {
    let mainView = PopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackgroundColorChange()
    }
    
    
}

//MARK: - Targets
extension CustomPopupViewController {
    @objc func closePopup() {
        view.backgroundColor = .clear
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goToVibrationSettingsPopup() {
        openVibrationSettings()
    }
}

//MARK: - Methods
extension CustomPopupViewController {
    private func initViewController() {
        mainView.backButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        mainView.goItButton.addTarget(self, action: #selector(goToVibrationSettingsPopup), for: .touchUpInside)
    }
    
    func animateBackgroundColorChange() {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = .black.withAlphaComponent(0.5)
        }
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
