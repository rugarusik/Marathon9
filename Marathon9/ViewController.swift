//
//  ViewController.swift
//  Marathon9
//
//  Created by Alina Golubeva on 25/05/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 100, height: 450)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 16
        
        return collectionViewLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 2 * collectionView.layoutMargins.left,
            bottom: 0,
            right: 2 * collectionView.layoutMargins.right
        )
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        title = "Collection"
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthWithSpacing = collectionViewLayout.itemSize.width + collectionViewLayout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        let index = (offset.x + collectionView.contentInset.left) / cellWidthWithSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthWithSpacing - collectionView.contentInset.left, y: -collectionView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 10
        
        return cell
    }
}
