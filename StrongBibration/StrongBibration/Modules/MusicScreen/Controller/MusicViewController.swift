//
//  MusicViewController.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 02.02.2024.
//

import UIKit
import MediaPlayer

struct MusicCellModel {
    var title: String
    var time: Double
}

class MusicViewController: UIViewController {
    private let mainView = MusicView()
    private let genresTitles = GenresModel.allCases
    
    var someData: [MusicCellModel] = []
    
    
    
    var selectedSong = "Vova"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        setupActions()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    private func initViewController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        mainView.titlesCollectionView.dataSource = self
        mainView.titlesCollectionView.delegate = self
        
        mainView.listsCollectionView.dataSource = self
        mainView.listsCollectionView.delegate = self
        
        mainView.titlesCollectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        mainView.listsCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ListCollectionViewCell")
        
        
    }
    
    private func setupActions() {
        mainView.backButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
    }
}

extension MusicViewController {
    @objc
    private func closeController() {
//        self.dismiss(animated: false)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: helpers
extension MusicViewController {
    private func cellForListsCollectionView(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        //                cell.model = hintsTitles[indexPath.item]
        cell.isActive = false
        
        return cell
    }
    
    private func cellForTitlesCollectionView(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.model = genresTitles[indexPath.item]
        cell.isActive = false
        
        return cell
    }
    
    private func labelWidthForTitle(at indexPath: IndexPath) -> CGFloat {
        let label = UILabel()
        label.text = genresTitles[indexPath.item].title
        label.font = UIFont.systemFont(ofSize: 14.sizeW, weight: .bold)
        label.sizeToFit()
        return label.frame.width
    }
    
    private func getSectionCount(collectionView: UICollectionView, section: Int) -> Int {
        switch collectionView {
        case mainView.listsCollectionView:
            return someData.count
        case mainView.titlesCollectionView:
            return genresTitles.count
        default:
            return 0
        }
    }
}

// MARK: setup collections view
extension MusicViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSectionCount(collectionView: collectionView, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.listsCollectionView:
            return cellForListsCollectionView(collectionView, indexPath)
        case mainView.titlesCollectionView:
            return cellForTitlesCollectionView(collectionView, indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainView.listsCollectionView:
            return CGSize(width: collectionView.bounds.width, height: 73.sizeH)
        case mainView.titlesCollectionView:
            return CGSize(width: (labelWidthForTitle(at: indexPath) + 32.sizeW), height: 34.sizeH)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == mainView.titlesCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
