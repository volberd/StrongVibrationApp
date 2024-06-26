//
//  CustomSlider.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 03.02.2024.
//

import UIKit

final class Slider: UISlider {
    private let baseLayer = CALayer()
    private let trackLayer = CAGradientLayer() 
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    private func setup() {
        clear()
        createBaseLayer()
        createThumbImageView()
        configureTrackLayer()
        addUserInteractions()
    }
    private func clear() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    // Step 3
    private func createBaseLayer() {
        baseLayer.masksToBounds = true
        baseLayer.frame = .init(x: 0, y: frame.height / 4, width: frame.width, height: frame.height / 3)
        baseLayer.cornerRadius = baseLayer.frame.height / 2
        layer.insertSublayer(baseLayer, at: 0)
    }
    // Step 7
    private func configureTrackLayer() {
        let firstColor = UIColor.theme(.purple).cgColor
        let secondColor = UIColor.theme(.lightPink).cgColor
        trackLayer.colors = [firstColor, secondColor]
        trackLayer.startPoint = .init(x: 0, y: 0.5)
        trackLayer.endPoint = .init(x: 1, y: 0.5)
        trackLayer.frame = .init(x: 0, y: frame.height / 4, width: 0, height: frame.height / 2)
        trackLayer.cornerRadius = trackLayer.frame.height / 2
        layer.insertSublayer(trackLayer, at: 1)
    }
    // Step 8
    private func addUserInteractions() {
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    @objc private func valueChanged(_ sender: Slider) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let thumbRectA = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
        trackLayer.frame = .init(x: 0, y: frame.height / 4, width: thumbRectA.midX, height: frame.height / 2)
        CATransaction.commit()
    }

    private func createThumbImageView() {
        let thumbSize = (3 * frame.height) / 4
        let thumbView = ThumbView(frame: .init(x: 0, y: 0, width: thumbSize, height: thumbSize))
        thumbView.layer.cornerRadius = thumbSize / 2
        let thumbSnapshot = thumbView.snapshot
        setThumbImage(thumbSnapshot, for: .normal)
        // Step 6
        setThumbImage(thumbSnapshot, for: .highlighted)
        setThumbImage(thumbSnapshot, for: .application)
        setThumbImage(thumbSnapshot, for: .disabled)
        setThumbImage(thumbSnapshot, for: .focused)
        setThumbImage(thumbSnapshot, for: .reserved)
        setThumbImage(thumbSnapshot, for: .selected)
    }
}

final class ThumbView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.theme(.darkPink)
        let thumbSize = frame.width * 1.5
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: thumbSize, height: thumbSize))
        middleView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        middleView.layer.cornerRadius = thumbSize / 2
        addSubview(middleView)
    }
}

extension UIView {
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
}
