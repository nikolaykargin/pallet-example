//
//  ViewController.swift
//  Pallet
//
//  Created by Nikolay Kargin on 21/01/2024.
//

import UIKit

final class ViewController: UIViewController {
    
    internal lazy var palletView: PalletView = {
        let view = PalletView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .systemBackground
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureView()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Title"
        navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(palletView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            palletView.leftAnchor.constraint(equalTo: view.leftAnchor),
            palletView.topAnchor.constraint(equalTo: view.topAnchor),
            palletView.contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            palletView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.top = palletView.frame.height - view.safeAreaInsets.top
        collectionView.verticalScrollIndicatorInsets.top = collectionView.contentInset.top
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollContentOffset = scrollView.contentOffset.y + palletView.frame.height
        if scrollContentOffset > 0.0 {
            UIView.animate(withDuration: 0.100, animations: {
                self.palletView.standardAppearance()
            })
        } else {
            UIView.animate(withDuration: 0.100, animations: {
                self.palletView.scrollEdgeAppearance()
            })
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        cell.label.text = "Item \(indexPath.item)"
        return cell
    }
    
}
