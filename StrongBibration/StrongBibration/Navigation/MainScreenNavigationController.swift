//
//  MainScreenNavigationController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 30.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    let bubbleTabBar = BubbleTabBar()
    let intensityViewController = IntensityViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarController()
        view.addSubview(bubbleTabBar)
        setupBubbleTabBar()
    }
    
    private func initBarController() {
        initNavigationController()
        selectedIndex = viewControllers?.firstIndex(where: { $0 is IntensityNavigationController }) ?? 0
    }
    
    private func initNavigationController() {
        let mainSettingsNavigationVC = SettingsNavigationController()
        let mainIntensityNavigationVC = IntensityNavigationController()
        let mainPatternsNavigationVC = PatternsNavigationController()
        
        viewControllers = [mainSettingsNavigationVC, mainIntensityNavigationVC, mainPatternsNavigationVC]
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBarHeight: CGFloat = 80.sizeH // Установите нужную высоту таб-бара
        bubbleTabBar.frame = CGRect(x: 0, y: view.frame.height - tabBarHeight, width: view.frame.width, height: tabBarHeight)
    }
    
    private func setupBubbleTabBar() {
        let tabs = [
            BubbleTabBar.Tab(id: "1", tint: .white, content: .image(uimage: UIImage(named: "gearIcon")!), title: "Settings"),
            BubbleTabBar.Tab(id: "2", tint: .white, content: .image(uimage: UIImage(named: "intencityIcon")!), title: "Intensity"),
            BubbleTabBar.Tab(id: "3", tint: .white, content: .image(uimage: UIImage(named: "patternsIcon")!), title: "Patterns"),
        ]
        
        bubbleTabBar.show(tabs: tabs)
        
        bubbleTabBar.didSelectTab
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .willSelect(let index):
                    if index == 2 {
                        self.presentPatternsViewControllerModally()
                    } else {
                        self.selectedIndex = index
                    }
                case .didSelect(let index):
                    print("Selected tab index: \(index)")
                    
                }
            }
            .store(in: &subscriptions)
    }
    
    private func presentPatternsViewControllerModally() {
            let patternsViewController = PatternsViewController()
            let navigationController = UINavigationController(rootViewController: patternsViewController)
            navigationController.modalPresentationStyle = .formSheet
            present(navigationController, animated: true, completion: nil)
        }

    
    
    private var subscriptions = Set<AnyCancellable>()
}

extension MainTabBarController {
    
    private func customizeBarItem() {
        let cornerRadius: CGFloat = 20.sizeH
        tabBar.layer.cornerRadius = cornerRadius
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundColor = .theme(.tabBarPink)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .theme(.white)
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
    }
}

extension MainTabBarController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Установка предыдущей выбранной табы после закрытия модального контроллера
        selectedIndex = bubbleTabBar.selectedIndex ?? 0
    }
}


import Foundation
import UIKit
import Combine

class BubbleTabBar: UIView {
    
    private static let cornerRadius: CGFloat = 8
    private static let itemWidth: CGFloat = 25
    private static let animationDuration: CGFloat = 0.3
    private lazy var ySelectedLocation: CGFloat = -Self.itemWidth/2
    private lazy var yUnselectedLocation: CGFloat = 3*Self.cornerRadius/2
    
    let gradientLayer = CAGradientLayer()
    
    
    /// View that represents the background of the tabBar
    private var backShape: CAShapeLayer = CAShapeLayer()
    
    /// Tabs shapes that will be drawn
    private var tabShapes: [TabLayer] = []
    
    /// signal called each time user select a new tab
    var didSelectTab: AnyPublisher<Event, Never> {
        _didSelectTab.eraseToAnyPublisher()
    }
    private var _didSelectTab: PassthroughSubject<Event, Never> = PassthroughSubject()
    
    /// Currents displayed tabs
    private var tabs: [Tab] = []
    
    /// Selected Tab
    private(set) var selectedTab: Tab?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureGestures()
    }
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(gesture:)))
        addGestureRecognizer(tapGesture)
    }
    
    /**
     Based on where the tap is detected, calculate the clicable area associated
     with the item that could be located around there
     */
    @objc private func onTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        let clickableRadius = 2*Self.itemWidth
        for i in 0..<tabs.count {
            let center = centerXFor(i)
            let clickableArea = (center-clickableRadius)...(center+clickableRadius)
            if clickableArea.contains(location.x) {
                
                selectAnimation(i, animated: i == 2 ? false : true)
                return
            }
        }
    }
    
    /**
     Redraw the tabs to display the given ones
     - parameter tabs: tabs to the drawn
     - throws: An assert exception if tabs array is empty
     */
    func show(tabs: [Tab]) {
        assert(!tabs.isEmpty, "One tab must be set at least")
        self.tabs = tabs
        selectedTab = tabs[1]
        redrawTabBar()
    }
    
    /**
     Select the given tab
     - parameter tab: The tab to be displayed
     - parameter animated: Define if the selection will be animated or not
     - note: If no tab will be found with the given tab id, this method do nothing
     */
    func select(_ tab: Tab, animated: Bool = true) {
        guard let index = selectedIndex else { return }
        selectAnimation(index, animated: animated)
    }
    
    /**
     Select the tab located at the given index
     - parameter index: The index to be displayed
     - parameter animated: Define if the selection will be animated or not
     - note: If no tab will be found with the given index, this method do nothing
     */
    func select(_ index: Int, animated: Bool = true) {
        guard index >= 0 && index < tabs.count else { return }
        selectAnimation(index, animated: animated)
    }
    
    /**
     Each time the view is resized, redraw all items
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        redrawTabBar()
    }
    
    private func redrawTabBar() {
        guard !tabs.isEmpty, selectedTab != nil else { return }
        addBackShapeIfNotAlreadyAdded()
        baseRedraw()
        redrawBackground()
        redrawTabs(tabs)
    }
    
    private func baseRedraw() {
        backShape.frame = bounds
        
        let maskPath = UIBezierPath(roundedRect: backShape.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 30.sizeH, height: 30.sizeH))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        backShape.mask = maskLayer
        
        backShape.fillColor = UIColor.theme(.darkPink).cgColor
    }
    
    
    /**
     Clean the current tabs and redraw the new ones
     - parameters tabs: Tabs to be drawn
     */
    private func redrawTabs(_ tabs: [Tab]) {
        tabShapes.forEach({ $0.removeFromSuperlayer() })
        tabShapes = []
        
        // Удаление предыдущих тайтлов
        subviews.compactMap { $0 as? UILabel }.forEach { $0.removeFromSuperview() }
        
        tabs.enumerated().forEach { item in
            let isSelected = item.element == selectedTab
            let tab = buildTabShapeFrom(item.element)
            tab.frame = frameForDotAt(item.offset, false)
            tabShapes.append(tab)
            layer.addSublayer(tab)
            tab.setSelected(isSelected, animated: false)
            
            // Добавляем тайтл к табе
            let titleLabel = UILabel()
            titleLabel.text = item.element.title
            titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            titleLabel.textAlignment = .center
            titleLabel.textColor = .white
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint(x: tab.position.x, y: frame.height/1.7) // Пересчитываем положение тайтла
            titleLabel.layer.zPosition = 1 // Устанавливаем zPosition для поднятия тайтлов
            addSubview(titleLabel)
        }
    }
    
    /**
     Build the layer that will be drawn into each tab
     - parameter tab: Generate and return a single tab
     */
    private func buildTabShapeFrom(_ tab: Tab) -> TabLayer {
        let tabLayer = TabLayer()
        tabLayer.frame = CGRect(origin: .zero, size: .init(width: Self.itemWidth, height: Self.itemWidth))
        tabLayer.configure(tab: tab)
        return tabLayer
    }
    
    /**
     Redraw the background tabbar
     */
    private func redrawBackground() {
        guard let index = selectedIndex else { return }
        let itemLocation = centerXFor(index)
        backShape.path = backgroundPath(itemLocation).cgPath
        backShape.fillColor = UIColor.theme(.darkPink).cgColor
    }
    
    /**
     Calculate the x location where each tab will be drawn based on
     the number of items of the tab and the index for the object
     */
    private func centerXFor(_ index: Int) -> CGFloat {
        if tabs.count <= 3 {
            return (bounds.width / CGFloat(1 + tabs.count)) * CGFloat(1 + index)
        }
        
        let startX = 2*Self.cornerRadius + Self.itemWidth
        let widthAvailable = bounds.width - 2 * startX
        let widthDelta = widthAvailable / CGFloat(tabs.count - 1)
        return startX + widthDelta * CGFloat(index)
    }
    
    /**
     Execute all the animations that must be perform when a tab is selected
     - parameter index: New index selected
     - parameter animated: mark if the items must be executed with animation
     */
    private func selectAnimation(_ index: Int, animated: Bool) {
        guard selectedTab != tabs[index] else { return }
        guard let previousIndex = selectedIndex else { return }
        
        _didSelectTab.send(.willSelect(index))
        if index != 2 {
            selectedTab = tabs[index]
        }
        
        
        // Animate background
        if animated {
            let bgAnimation = backShapeAnimation(fromIndex: previousIndex, toIndex: index)
            backShape.add(bgAnimation, forKey: AnimationKeys.backgroundShiftKey)
        } else {
            backShape.path = backgroundPath(centerXFor(index)).cgPath
        }
        
        
        let fromDot = tabShapes[previousIndex]
        let toDot = tabShapes[index]
        
        fromDot.setSelected(false, animated: animated)
        toDot.setSelected(true, animated: animated)
        
        // Animate dots between
        if animated && abs(index - previousIndex) > 1 {
            let start = (1+min(previousIndex, index))
            let end = max(previousIndex, index)
            let dotsIndeces = start..<end
            
            dotsIndeces.forEach { dotIndex in
                let tab = tabShapes[dotIndex]
                tab.applyShiftDownAnimation()
            }
        }
    }
    
    private func backShapeAnimation(fromIndex from: Int, toIndex to: Int) -> CAAnimation {
        let previousLocation = centerXFor(from)
        let futureLocation = centerXFor(to)
        let anim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        anim.duration = Self.animationDuration
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.fromValue = backgroundPath(previousLocation).cgPath
        anim.toValue = backgroundPath(futureLocation).cgPath
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        anim.delegate = self
        return anim
    }
    
    /**
     Define the background bezier path using the `centerX` as the
     location of the selected index
     - parameter centerX: Location of the selected index
     */
    private func backgroundPath(_ centerX: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.width, y: 0))
        path.addLine(to: .init(x: bounds.width, y: bounds.height))
        path.addLine(to: .init(x: 0, y: bounds.height))
        path.addLine(to: .init(x: 0, y: 0))
        
        let until = centerX - 2*Self.itemWidth
        path.addLine(to: .init(x: until, y: 0))
        
        let additionalMargin: CGFloat = 10
        path.addCurve(
            to: .init(x: centerX, y: Self.itemWidth + additionalMargin),
            controlPoint1: .init(x: centerX - Self.itemWidth, y: 0),
            controlPoint2: .init(x: centerX - Self.itemWidth, y: Self.itemWidth + additionalMargin))
        
        path.addCurve(
            to: .init(x: centerX + 2*Self.itemWidth, y: 0),
            controlPoint1: .init(x: centerX + Self.itemWidth, y: Self.itemWidth + additionalMargin),
            controlPoint2: .init(x: centerX + Self.itemWidth, y: 0))
        
        path.close()
        
        return path
    }
    
    /**
     Add the background shaper layer if is not added already
     */
    private func addBackShapeIfNotAlreadyAdded() {
        guard backShape.superlayer == nil else { return }
        layer.addSublayer(backShape)
    }
    
    /**
     Return the frame where for the a tab must be located based on its
     index and selection status
     - parameter index: Index of the item to calculate
     - parameter isSelected: Mark if the tab is selected or not
     */
    private func frameForDotAt(_ index: Int, _ isSelected: Bool) -> CGRect {
        CGRect(x: centerXFor(index) - Self.itemWidth / 2.0,
               y: isSelected ? ySelectedLocation : yUnselectedLocation,
               width: Self.itemWidth,
               height: Self.itemWidth)
    }
}

extension BubbleTabBar {
    
    enum Event {
        case willSelect(_ index: Int)
        case didSelect(_ index: Int)
    }
    
    enum TabContent {
        case image(uimage: UIImage)
    }
    
    struct Tab: Equatable, Identifiable {
        var id: String
        let tint: UIColor
        let content: TabContent
        let title: String // Добавлено свойство для тайтла
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
}

private extension BubbleTabBar {
    
    /// Return the index of the current selected tab
    var selectedIndex: Int? {
        tabs.firstIndex(where: { $0.id == selectedTab?.id })
    }
}

private struct AnimationKeys {
    static let backgroundShiftKey = "bg_shift"
    static let tabShiftKey = "tab_shift"
    static let tabBackgroundKey = "tab_bg_shift"
    static let tabBetweenKey = "tabBetween"
}

extension BubbleTabBar: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if backShape.animation(forKey: AnimationKeys.backgroundShiftKey) == anim {
            guard let index = selectedIndex else { return }
            backShape.path = backgroundPath(centerXFor(index)).cgPath
            _didSelectTab.send(.didSelect(selectedIndex ?? 0))
        }
    }
}

private class TabLayer: CAShapeLayer, CAAnimationDelegate {
    
    private static let animationDuration: CGFloat = 0.3
    private var backgroundLayer: CAShapeLayer?
    private var imageLayer: CAShapeLayer?
    private var ySelectedLocation: CGFloat {
        -bounds.width/2
    }
    private var selectedTransform: CATransform3D {
        (CATransform3DMakeTranslation(0, 2*ySelectedLocation, 0))
    }
    private var unSelectedTransform: CATransform3D = CATransform3DIdentity
    
    private(set) var tab: BubbleTabBar.Tab!
    private(set) var isSelected: Bool = false
    
    func configure(tab: BubbleTabBar.Tab) {
        self.tab = tab
        buildLayers()
        setSelected(false, animated: false)
    }
    
    func setSelected(_ isSelected: Bool, animated: Bool) {
        self.isSelected = isSelected
        guard animated else {
            transform = isSelected ? selectedTransform : unSelectedTransform
            backgroundLayer?.fillColor = isSelected ? UIColor.theme(.darkPink).cgColor : UIColor.clear.cgColor
            imageLayer?.backgroundColor = isSelected ? tab.tint.cgColor : UIColor.white.cgColor
            return
        }
        
        imageLayer?.backgroundColor = isSelected ? tab.tint.cgColor : UIColor.theme(.lightPink).cgColor
        let fromShiftValue = isSelected ? unSelectedTransform : selectedTransform
        let toShiftValue = isSelected ? selectedTransform : unSelectedTransform
        
        let moveAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        moveAnimation.duration = Self.animationDuration
        moveAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        moveAnimation.fromValue = fromShiftValue
        moveAnimation.toValue = toShiftValue
        moveAnimation.fillMode = .forwards
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.delegate = self
        
        let fromBgValue = isSelected ? UIColor.clear.cgColor : UIColor.clear.cgColor
        let toBgValue = isSelected ? UIColor.clear.cgColor : UIColor.clear.cgColor
        
        let bgAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        bgAnimation.duration = Self.animationDuration
        bgAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        bgAnimation.fromValue = fromBgValue
        bgAnimation.toValue = toBgValue
        bgAnimation.fillMode = .forwards
        bgAnimation.isRemovedOnCompletion = false
        bgAnimation.delegate = self
        
        add(moveAnimation, forKey: AnimationKeys.tabShiftKey)
        backgroundLayer?.add(bgAnimation, forKey: AnimationKeys.tabBackgroundKey)
    }
    
    func applyShiftDownAnimation() {
        var transform = CATransform3DMakeTranslation(0, 18, 0)
        transform = CATransform3DScale(transform, 0.2, 0.2, 1)
        
        let anim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        anim.duration = Self.animationDuration / 2
        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        anim.fromValue = self.transform
        anim.toValue = transform
        anim.fillMode = .both
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        add(anim, forKey: AnimationKeys.tabBetweenKey)
    }
    
    private func buildLayers() {
        let width = bounds.width
        let bgShape = CAShapeLayer()
        bgShape.frame = .init(x: -width/2, y: -width/2, width: 2*width, height: 2*width)
        bgShape.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 2*width, height: 2*width))).cgPath
        bgShape.fillColor = UIColor.clear.cgColor
        addSublayer(bgShape)
        
        let imageContainerShape = CAShapeLayer()
        imageContainerShape.frame = .init(origin: .zero, size: .init(width: width, height: width))
        
        let imageShape = CAShapeLayer()
        imageShape.frame = imageContainerShape.frame
        if case let BubbleTabBar.TabContent.image(uiImage) = tab.content {
            imageShape.contents = uiImage.cgImage
            imageShape.contentsGravity = .resizeAspect
        }
        
        imageContainerShape.mask = imageShape
        addSublayer(imageContainerShape)
        
        backgroundLayer = bgShape
        imageLayer = imageContainerShape
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let isShiftAnimation = animation(forKey: AnimationKeys.tabShiftKey) == anim
        let isBackgroundTabAnimation = backgroundLayer?.animation(forKey: AnimationKeys.backgroundShiftKey) == anim
        
        if isShiftAnimation {
            transform = isSelected ? selectedTransform : unSelectedTransform
        } else if isBackgroundTabAnimation {
            backgroundLayer?.fillColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
        }
    }
}
