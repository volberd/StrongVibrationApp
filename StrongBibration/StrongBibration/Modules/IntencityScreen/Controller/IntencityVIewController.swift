//
//  IntencityVIewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import AudioToolbox


class IntensityViewController: UIViewController, CustomSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: CustomSegmentedControl, didSelectItemAt index: Int) {
        
    }
    
    private let mainView = IntensityView()
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var selectedMode: ChooseStateModel?
    var isVibrating = false
    var selectedIndex: Int32 = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        mainView.segmentedControl.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(patternSelected(_:)), name: NSNotification.Name("PatternSelected"), object: nil)

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainView.layoutIfNeeded()
        mainView.stopAnimation()
    }
    
    private func initViewController() {
        mainView.vibrateButton.addTarget(self, action: #selector(vibrateButtonTapped), for: .touchUpInside)
        mainView.musicButton.addTarget(self, action: #selector(openMusicController), for: .touchUpInside)
        mainView.lockButton.addTarget(self, action: #selector(blockButtonTaped), for: .touchUpInside)
        mainView.notVibrationButton.addTarget(self, action: #selector(showCustomPopup), for: .touchUpInside)
    }
    
    @objc private func patternSelected(_ notification: Notification) {
           if let selectedModel = notification.object as? PatternModel {
               mainView.stateView.model = ChooseStateModel(title: selectedModel.title, icon: selectedModel.iconString)
           }
       }
}


//MARK: - Actions
extension IntensityViewController {
    @objc
    private func vibrateButtonTapped() {
        if mainView.isAnimating {
            mainView.stopAnimation()
            stopVibrating()
        } else {
            mainView.animateWaveView()
            startVibrating()
            impactFeedbackGenerator.impactOccurred()
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
    
    @objc
    private func showCustomPopup() {
        let popupVC = CustomPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .flipHorizontal
        present(popupVC, animated: true) {
      
        }
    }
    
    func startVibrating() {
        isVibrating = true
        if mainView.segmentedControl.selectedIndex == 0 {
            selectedIndex = 1000000
        } else if mainView.segmentedControl.selectedIndex == 1 {
            selectedIndex = 500000
        } else {
            selectedIndex = 10000
        }

        DispatchQueue.global().async {
            while self.isVibrating {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                usleep(useconds_t(self.selectedIndex))
            }
        }
    }

      
      func stopVibrating() {
          isVibrating = false
      }
    
    func reloadView(model: String) {
        DispatchQueue.main.async {
               let alert = UIAlertController(title: model, message: nil, preferredStyle: .alert)
               let action = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(action)
               
               self.present(alert, animated: true, completion: nil)
           }
    }
}
