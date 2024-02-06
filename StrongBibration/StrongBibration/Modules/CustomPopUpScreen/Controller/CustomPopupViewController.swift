//
//  CustomPopupViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 06.02.2024.
//

import UIKit
import SnapKit

class CustomPopupViewController: UIViewController {

    let popupView = UIView()
    let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        // Add popup view
        view.addSubview(popupView)
        popupView.backgroundColor = .white
        popupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.5)
        }

        // Add close button
        popupView.addSubview(closeButton)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        // You can add other subviews and customize the popup view here
    }

    @objc func closePopup() {
        dismiss(animated: true, completion: nil)
    }
}
