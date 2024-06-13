//
//  IntencityVIewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit
import AudioToolbox


class IntensityViewController: UIViewController, CustomSegmentedControlDelegate {
    private let mainView = IntensityView()
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var selectedMode: ChooseStateModel?
    var isVibrating = false
    var selectedIndex: Int32 = 0
    var isBlockView = false
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isVibrating {
            mainView.animateWaveView()
        }
    }
    
    private func initViewController() {
        mainView.vibrateButton.addTarget(self, action: #selector(vibrateButtonTapped), for: .touchUpInside)
        mainView.musicButton.addTarget(self, action: #selector(openMusicController), for: .touchUpInside)
        mainView.lockButton.addTarget(self, action: #selector(blockButtonTaped), for: .touchUpInside)
        mainView.notVibrationButton.addTarget(self, action: #selector(showCustomPopup), for: .touchUpInside)
        mainView.customSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

    }
    
    @objc private func patternSelected(_ notification: Notification) {
           if let selectedModel = notification.object as? PatternModel {
               mainView.stateView.model = ChooseStateModel(title: selectedModel.title, icon: selectedModel.iconString)
           }
       }
}


//MARK: - Actions
extension IntensityViewController {
    @objc private func sliderValueChanged() {
        if isVibrating {
            startVibrating()
        }
    }
    
    @objc
    private func vibrateButtonTapped() {
        if mainView.isAnimating {
            isVibrating = false
            mainView.stopAnimation()
            stopVibrating()
        } else {
            isVibrating = true
            mainView.animateWaveView()
            startVibrating()
            impactFeedbackGenerator.impactOccurred()
        }
    }
    
    @objc
    private func openMusicController() {
        let vc = MusicViewController()
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc
    private func blockButtonTaped() {
        isBlockView = true
        let vc = LockViewController()
        vc.modalPresentationStyle = .fullScreen
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
        if isVibrating {
            let intensity = calculateIntensity()
            DispatchQueue.global().async {
                while self.isVibrating {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    usleep(useconds_t(intensity))
                }
            }
        }
    }

    func calculateIntensity() -> Int32 {
        let sliderValue = mainView.customSlider.value
        let segmentedControlIndex = mainView.segmentedControl.selectedIndex
        var intensity: Int32 = 0
        
        switch segmentedControlIndex {
        case 0:
            intensity = Int32(1000000 - sliderValue * 50000)
        case 1:
            intensity = Int32(500000 - sliderValue * 25000)
        case 2:
            intensity = Int32(10000 - sliderValue * 500)
        default:
            break
        }
        
        return intensity
    }


      
      func stopVibrating() {
          isVibrating = false
      }
    
    func reloadView(model: String) {

    }
    
    func segmentedControl(_ segmentedControl: CustomSegmentedControl, didSelectItemAt index: Int) {
        if isVibrating {
            startVibrating()
        }
    }
}
