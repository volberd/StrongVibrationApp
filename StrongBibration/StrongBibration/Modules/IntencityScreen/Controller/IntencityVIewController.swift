//
//  IntencityVIewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class IntensityViewController: UIViewController {
    private let mainView = IntensityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainView.stopAnimation()
    }
    
    private func initViewController() {
        mainView.vibrateButton.addTarget(self, action: #selector(vibrateButtonTapped), for: .touchUpInside)
        mainView.musicButton.addTarget(self, action: #selector(openMusicController), for: .touchUpInside)
        mainView.lockButton.addTarget(self, action: #selector(blockButtonTaped), for: .touchUpInside)
    }
}


//MARK: - Actions
extension IntensityViewController {
    @objc
    private func vibrateButtonTapped() {
        if mainView.isAnimating {
            mainView.stopAnimation()
        } else {
            mainView.animateWaveView()
        }
    }
    
    
    @objc
    private func openMusicController() {
        let vc = MusicViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false) {
            print(vc.selectedSong)
        }
    }
    
    @objc
    private func blockButtonTaped() {
        let vc = LockViewController()
        self.present(vc, animated: true) {
        }
    }
}
