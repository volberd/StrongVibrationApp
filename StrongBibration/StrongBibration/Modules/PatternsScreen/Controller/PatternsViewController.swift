//
//  PatternsViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import UIKit

class PatternsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let mainView = PatternsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            make.height.equalTo(498.sizeH)
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}

//MARK: - Setup CollectionView
extension PatternsViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PatternCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Здесь вы можете установить размер каждой ячейки
           let itemWidth = (collectionView.bounds.width - 58) / 3 // 58 - сумма расстояний между ячейками и краями
           return CGSize(width: itemWidth, height: itemWidth)
       }
}
